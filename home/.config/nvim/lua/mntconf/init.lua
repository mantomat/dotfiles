vim.g.mapleader = " "
vim.g.maplocalleader = " "

require("mntconf.keymaps").init()
require("mntconf.opts")
require("mntconf.lazy")

vim.api.nvim_create_autocmd("TextYankPost", {
    desc = "Highlight when yanking (copying) text",
    group = vim.api.nvim_create_augroup("kickstart-highlight-yank", { clear = true }),
    callback = function()
        vim.highlight.on_yank()
    end,
})
