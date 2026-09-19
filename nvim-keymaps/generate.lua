-- Collect every key mapping of this Neovim setup and write keymaps.js for index.html.
-- Run from the UwU repo root:
--   nvim --headless -c "luafile nvim-keymaps/generate.lua"
--
-- Global mappings are read directly. Buffer-local ones only exist in certain buffers,
-- so a Python file (LSP), Neo-tree and the Telescope prompt are opened to capture
-- them. nvim-cmp keys are read from its config, as they only exist while its menu is open.

local out_file = vim.fn.fnamemodify(debug.getinfo(1, "S").source:sub(2), ":p:h") .. "/keymaps.js"
local config_dir = vim.fn.resolve(vim.fn.stdpath("config"))
local lazy_dir = vim.fn.stdpath("data") .. "/lazy/"
local runtime_dir = vim.env.VIMRUNTIME

local maps, seen = {}, {}

local mode_names = {
	[" "] = "n v o", ["!"] = "i c", n = "n", i = "i", v = "v s", x = "v", s = "s",
	o = "o", c = "c", t = "t", l = "l",
}

-- Where a mapping comes from: your config, a plugin, or Neovim itself
local function origin(m)
	local sid = m.sid or 0
	local script = sid > 0 and (vim.fn.getscriptinfo({ sid = sid })[1] or {}).name or nil
	script = script and vim.fn.resolve(script)
	local file
	if m.callback then
		local src = debug.getinfo(m.callback, "S").source
		if src:sub(1, 1) == "@" then
			file = vim.fn.resolve(src:sub(2))
		end
	end
	local function in_config(p)
		return p and (p:find(config_dir, 1, true) == 1 or p:find("/UwU/", 1, true)) and true or false
	end
	if in_config(file) then
		return "config", vim.fn.fnamemodify(file, ":t")
	end
	if script and script:find(lazy_dir, 1, true) == 1 then
		return "plugin", script:sub(#lazy_dir + 1):match("^[^/]+")
	end
	if file and file:find(lazy_dir, 1, true) == 1 then
		return "plugin", file:sub(#lazy_dir + 1):match("^[^/]+")
	end
	if in_config(script) then
		return "config", nil
	end
	if sid == -8 or (script and runtime_dir and script:find(runtime_dir, 1, true) == 1) then
		return "default", nil
	end
	return "other", nil
end

local function lhs_text(m)
	local t = vim.fn.keytrans(m.lhsraw or m.lhs)
	if vim.g.mapleader == " " then
		t = t:gsub("^<Space>", "<leader>")
	end
	return t
end

local function add(m, context, default_context)
	if m.lhs:find("<Plug>", 1, true) or m.lhs:find("<SNR>", 1, true) or m.lhs:find("\128\253", 1, true) then
		return
	end
	local mode = mode_names[m.mode] or m.mode
	local key = mode .. "\0" .. m.lhs .. "\0" .. context
	if seen[key] then
		return
	end
	seen[key] = true
	local source, file = origin(m)
	if source == "default" and default_context then
		context = default_context
	end
	local rhs = m.rhs
	if (not rhs or rhs == "") and m.callback then
		rhs = "Lua function"
	end
	table.insert(maps, {
		mode = mode,
		lhs = lhs_text(m),
		desc = m.desc or "",
		rhs = rhs or "",
		source = source,
		plugin = source == "plugin" and file or nil,
		file = source == "config" and file or nil,
		context = context,
	})
end

local modes = { "n", "i", "v", "x", "s", "o", "c", "t" }

local function collect_global()
	for _, mode in ipairs(modes) do
		for _, m in ipairs(vim.api.nvim_get_keymap(mode)) do
			add(m, "global")
		end
	end
end

local function collect_buffer(buf, context, default_context)
	for _, mode in ipairs(modes) do
		for _, m in ipairs(vim.api.nvim_buf_get_keymap(buf, mode)) do
			add(m, context, default_context)
		end
	end
end

local function find_buf(ft)
	for _, b in ipairs(vim.api.nvim_list_bufs()) do
		if vim.api.nvim_buf_is_loaded(b) and vim.bo[b].filetype == ft then
			return b
		end
	end
end

-- Let lazy-loaded plugins (VeryLazy) finish
vim.api.nvim_exec_autocmds("User", { pattern = "VeryLazy", modeline = false })
vim.wait(500)
collect_global()

-- LSP: buffer mappings appear once a server attaches
local py = vim.fn.tempname() .. ".py"
vim.fn.writefile({ "def f(x):", "    return x" }, py)
vim.cmd.edit(py)
local buf = vim.api.nvim_get_current_buf()
local attached = vim.wait(20000, function()
	return #vim.lsp.get_clients({ bufnr = buf }) > 0
end, 100)
vim.wait(300)
collect_buffer(buf, attached and "LSP buffer" or "buffer", "Python file")

-- Completion: nvim-cmp only maps its keys while its menu is active, so read its config
local cmp_desc = {
	["<C-B>"] = "Scroll docs up", ["<C-F>"] = "Scroll docs down", ["<C-Space>"] = "Open completion menu",
	["<C-E>"] = "Close completion menu", ["<CR>"] = "Confirm selection", ["<C-Y>"] = "Confirm selection",
	["<C-N>"] = "Next item", ["<Down>"] = "Next item", ["<C-P>"] = "Previous item", ["<Up>"] = "Previous item",
}
local ok_cmp, cmp = pcall(require, "cmp")
if ok_cmp then
	for key, modes_tbl in pairs(cmp.get_config().mapping or {}) do
		for mode in pairs(type(modes_tbl) == "table" and modes_tbl or { i = true }) do
			table.insert(maps, {
				mode = mode_names[mode] or mode, lhs = key, desc = cmp_desc[key] or "nvim-cmp action",
				rhs = "", source = "config", file = "completions.lua", context = "completion menu",
			})
		end
	end
end

-- Neo-tree window
pcall(vim.cmd, "Neotree filesystem left")
if vim.wait(5000, function() return find_buf("neo-tree") ~= nil end, 100) then
	collect_buffer(find_buf("neo-tree"), "Neo-tree window")
end
pcall(vim.cmd, "Neotree close")

-- Telescope prompt
pcall(function() require("telescope.builtin").find_files() end)
if vim.wait(5000, function() return find_buf("TelescopePrompt") ~= nil end, 100) then
	collect_buffer(find_buf("TelescopePrompt"), "Telescope prompt")
end

-- Find which config file defines a mapping by searching for its key as written there
local sources = {}
for _, f in ipairs(vim.fn.globpath(config_dir, "**/*.lua", false, true)) do
	sources[vim.fn.fnamemodify(f, ":t")] = table.concat(vim.fn.readfile(f), "\n"):lower()
end
for _, m in ipairs(maps) do
	if m.source == "config" and not m.file then
		local needle = m.lhs:lower()
		for name, text in pairs(sources) do
			if text:find('"' .. needle .. '"', 1, true) or text:find("'" .. needle .. "'", 1, true) then
				m.file = name
				break
			end
		end
	end
end

table.sort(maps, function(a, b)
	local order = { config = 1, plugin = 2, default = 3, other = 4 }
	if a.source ~= b.source then
		return order[a.source] < order[b.source]
	end
	if a.context ~= b.context then
		local rank = { global = 1, ["LSP buffer"] = 2, ["completion menu"] = 3 }
		local ra, rb = rank[a.context] or 9, rank[b.context] or 9
		if ra ~= rb then
			return ra < rb
		end
		return a.context < b.context
	end
	return a.lhs:lower() < b.lhs:lower()
end)

local v = vim.version()
local data = {
	generated = os.date("%Y-%m-%d %H:%M"),
	nvim = string.format("%d.%d.%d", v.major, v.minor, v.patch),
	leader = vim.fn.keytrans(vim.g.mapleader or "\\"),
	maps = maps,
}
vim.fn.writefile({ "// Generated by generate.lua. Do not edit by hand.", "window.KEYMAPS = " .. vim.json.encode(data) .. ";" }, out_file)
io.stdout:write(string.format("%d mappings -> %s\n", #maps, out_file))
os.remove(py)
vim.cmd("qa!")
