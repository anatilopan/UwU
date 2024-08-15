return {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-tree/nvim-web-devicons",
        "MunifTanjim/nui.nvim",
        "3rd/image.nvim",
    },
    lazy = false,
    config = function()
        require("neo-tree").setup({
            window = {
                mappings = {
                    ["P"] = { "toggle_preview", config = { use_float = false, use_image_nvim = true } },
                },
            },
        })
        vim.keymap.set("n", "<C-n>", ":Neotree filesystem reveal left<CR>")
    end,
}
