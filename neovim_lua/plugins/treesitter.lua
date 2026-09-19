-- nvim-treesitter `main` branch: the plugin only installs parsers,
-- highlighting/indentation are switched on per buffer below.
-- Needs tree-sitter-cli and a C compiler.
local parsers = { "lua", "javascript", "python", "html", "css", "markdown", "markdown_inline", "bash", "json" }

return {
	"nvim-treesitter/nvim-treesitter",
	branch = "main",
	build = ":TSUpdate",
	lazy = false,
	config = function()
		local ts = require("nvim-treesitter")
		ts.install(parsers)

		local function enable(buf)
			if pcall(vim.treesitter.start, buf) then
				vim.bo[buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
			end
		end

		vim.api.nvim_create_autocmd("FileType", {
			group = vim.api.nvim_create_augroup("UserTreesitter", {}),
			callback = function(args)
				local lang = vim.treesitter.language.get_lang(args.match)
				if not lang then
					return
				end
				-- auto_install: fetch a missing parser in the background, then enable it
				if not vim.list_contains(ts.get_installed(), lang) and vim.list_contains(ts.get_available(), lang) then
					ts.install(lang):await(function()
						vim.schedule(function()
							if vim.api.nvim_buf_is_valid(args.buf) then
								enable(args.buf)
							end
						end)
					end)
					return
				end
				enable(args.buf)
			end,
		})
	end,
}
