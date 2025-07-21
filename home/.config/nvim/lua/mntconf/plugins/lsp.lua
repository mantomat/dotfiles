return {
    {
        dependencies = {
            {
                "williamboman/mason.nvim",
                opts = {},
            },
            {
                "williamboman/mason-lspconfig.nvim",
                opts = {},
            },

            {
                "folke/lazydev.nvim",
                ft = "lua", -- only load on lua files
                opts = {
                    library = {
                        -- See the configuration section for more details
                        -- Load luvit types when the `vim.uv` word is found
                        { path = "${3rd}/luv/library", words = { "vim%.uv" } },
                    },
                },
            },
        },
        "neovim/nvim-lspconfig",
        config = function()
            local lspconfig = require("lspconfig")
            local mason_lspconfig = require("mason-lspconfig")
            local capabilities = require("blink.cmp").get_lsp_capabilities()

            -- Automatically setup Mason-installed LSPs with LSPConfig
            mason_lspconfig.setup_handlers({
                function(server_name) -- Default handler
                    lspconfig[server_name].setup({
                        capabilities = capabilities,
                    })
                end,
            })

            vim.api.nvim_create_autocmd("LspAttach", {
                group = vim.api.nvim_create_augroup("kickstart-lsp-attach", { clear = true }),
                callback = function(event)
                    require("mntconf.keymaps").lsp()
                    -- TODO this was difficult to put in the keymaps (I could do it one day)
                    local client = vim.lsp.get_client_by_id(event.data.client_id)
                    if client and client.supports_method(vim.lsp.protocol.Methods.textDocument_inlayHint) then
                        vim.keymap.set("n", "<leader>ch", function()
                            vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = event.buf }))
                        end, { buffer = event.buf, desc = "Toggle Inlay [H]ints" })
                    end
                end,
            })
        end,
    },
}
