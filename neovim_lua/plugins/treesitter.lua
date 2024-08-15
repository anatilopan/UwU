return {
	"nvim-treesitter/nvim-treesitter",
	build = ":TSUpdate",
	lazy = false,
	config = function()
		local config = require("nvim-treesitter.configs")

		config.setup({
			ensure_installed = { "lua", "javascript", "python", "html", "css", "markdown" },
			auto_install = true,
			highlight = { enable = true },
			indent = { enable = true },
		})
	end,
}
