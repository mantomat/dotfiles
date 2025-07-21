local M = {}

M.init = function()
    vim.keymap.set("n", "<leader>np", "<cmd>Ex<cr>", { desc = "[N]avigate [P]roject" })

    vim.keymap.set("n", "<C-D>", "<C-D>zz", { desc = "Center cursor when scrolling down" })
    vim.keymap.set("n", "<C-U>", "<C-U>zz", { desc = "Center cursor when scrolling up" })

    vim.keymap.set("n", "<leader>M", "<cmd>Mason<cr>", { desc = "[M]ason" })
    vim.keymap.set("n", "<leader>L", "<cmd>Lazy<cr>", { desc = "[L]azy" })

    vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<cr>", { desc = "Disable highlighting" })
end

M.whichkey = function()
    local wk = require("which-key")
    wk.add({
        { "<leader>n", group = "[N]avigate" },
        { "<leader>s", group = "[S]earch" },
        { mode = { "n", "v" }, "<leader>c", group = "[C]ode" },
    })
end

M.telescope = function()
    local telescope_builtin = require("telescope.builtin")
    vim.keymap.set("n", "<leader>sf", telescope_builtin.find_files, { desc = "[F]iles" })
    vim.keymap.set("n", "<leader>sb", telescope_builtin.buffers, { desc = "open [B]uffers" })
    vim.keymap.set("n", "<leader>sh", telescope_builtin.help_tags, { desc = "[H]elp" })
    vim.keymap.set("n", "<leader>sg", telescope_builtin.live_grep, { desc = "live-[G]rep" })
    vim.keymap.set("n", "<leader>s/", telescope_builtin.current_buffer_fuzzy_find, { desc = "current buffer" })
    vim.keymap.set("n", "<leader>ss", telescope_builtin.lsp_document_symbols, { desc = "document [S]ymbols" })
    vim.keymap.set("n", "<leader>sr", telescope_builtin.oldfiles, { desc = "[R]ecent files" })
end

M.lsp = function()
    local telescope_builtin = require("telescope.builtin")
    vim.keymap.set({ "n", "v" }, "<leader>r", vim.lsp.buf.rename, { desc = "[R]ename" })
    vim.keymap.set({ "n", "v" }, "<leader>cd", telescope_builtin.lsp_definitions, { desc = "[D]efinition" })
    vim.keymap.set({ "n", "v" }, "<leader>ci", telescope_builtin.lsp_implementations, { desc = "[I]mplementations" })
    vim.keymap.set({ "n", "v" }, "<leader>cr", telescope_builtin.lsp_references, { desc = "[R]eferences" })
    vim.keymap.set(
        { "n", "v" },
        "<leader>cc",
        telescope_builtin.lsp_incoming_calls,
        { desc = "[C]ode incoming [C]alls" }
    )
    vim.keymap.set(
        { "n", "v" },
        "<leader>cC",
        telescope_builtin.lsp_outgoing_calls,
        { desc = "[C]ode outgoing [C]alls" }
    )
    vim.keymap.set("n", "<leader>q", function()
        vim.diagnostic.setqflist({ open = true, scope = "buffer" })
    end, { desc = "[Q]uickfix" })
    vim.keymap.set("n", "<leader>cs", "<cmd>ClangdSwitchSourceHeader<cr>", { desc = "[S]witch Source-Header C/C++" })
end

M.actionspreview = function()
    vim.keymap.set({ "n", "v" }, "<leader>a", require("actions-preview").code_actions, { desc = "[A]ction" })
end

M.conform = function()
    vim.keymap.set({ "n", "v" }, "<leader>f", function()
        require("conform").format({ lsp_format = "fallback" })
    end, { desc = "[F]ormat" })
end

M.cmp = function()
    local cmp = require("cmp")
    return {
        ["<C-b>"] = cmp.mapping.scroll_docs(-4),
        ["<C-f>"] = cmp.mapping.scroll_docs(4),
        ["<C-Space>"] = cmp.mapping.complete(),
        ["<C-e>"] = cmp.mapping.abort(),
        ["<C-y>"] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
    }
end

return M
