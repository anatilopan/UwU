return {
    {
        "williamboman/mason.nvim",
        lazy = false,
        config = function()
            require("mason").setup()
        end,
    },
    {
        "williamboman/mason-lspconfig.nvim",
        config = function()
            require("mason-lspconfig").setup({
                ensure_installed = {
                    "lua_ls",
                    "jsonls",
                    "marksman",
                    "pyright",
                },
            })
        end,
    },
    {
        "neovim/nvim-lspconfig",
        config = function()
            -- Neovim 0.11+ API: nvim-lspconfig only ships the server defaults,
            -- mason-lspconfig enables every installed server automatically
            vim.lsp.config("*", {
                capabilities = require("cmp_nvim_lsp").default_capabilities(),
            })

            -- Global mappings.
            -- See `:help vim.diagnostic.*` for documentation on any of the below functions
            vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float, { desc = "Show diagnostic under cursor" })
            vim.keymap.set("n", "[d", function() vim.diagnostic.jump({ count = -1, float = true }) end, { desc = "Previous diagnostic" })
            vim.keymap.set("n", "]d", function() vim.diagnostic.jump({ count = 1, float = true }) end, { desc = "Next diagnostic" })
            vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Diagnostics to location list" })

            -- Use LspAttach autocommand to only map the following keys
            -- after the language server attaches to the current buffer
            vim.api.nvim_create_autocmd("LspAttach", {
                group = vim.api.nvim_create_augroup("UserLspConfig", {}),
                callback = function(ev)
                    -- Enable completion triggered by <c-x><c-o>
                    vim.bo[ev.buf].omnifunc = "v:lua.vim.lsp.omnifunc"
                    -- Buffer local mappings.
                    -- See `:help vim.lsp.*` for documentation on any of the below functions
                    local function opts(desc)
                        return { buffer = ev.buf, desc = "LSP: " .. desc }
                    end
                    -- local opts = {}
                    vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts("Go to declaration"))
                    vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts("Go to definition"))
                    vim.keymap.set("n", "K", vim.lsp.buf.hover, opts("Hover documentation"))
                    vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts("Go to implementation"))
                    vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, opts("Signature help"))
                    vim.keymap.set("n", "<leader>wa", vim.lsp.buf.add_workspace_folder, opts("Add workspace folder"))
                    vim.keymap.set("n", "<leader>wr", vim.lsp.buf.remove_workspace_folder, opts("Remove workspace folder"))
                    vim.keymap.set("n", "<leader>wl", function()
                        print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
                    end, opts("List workspace folders"))
                    vim.keymap.set("n", "<leader>D", vim.lsp.buf.type_definition, opts("Go to type definition"))
                    vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts("Rename symbol"))
                    vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts("Code action"))
                    vim.keymap.set("n", "<leader>f", function()
                        vim.lsp.buf.format({ async = true })
                    end, opts("Format buffer"))
                end,
            })
        end,
    },
}
