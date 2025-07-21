vim.g.mapleader = " "
vim.g.maplocalleader = " "

vim.keymap.set("n", "<C-d>", "<C-d>zz", { desc = "Center pointer when scrolling down" })
vim.keymap.set("n", "<C-u>", "<C-u>zz", { desc = "Center pointer when scrolling up" })

vim.keymap.set("n", "<Leader>p", "<cmd>Ex<CR>", { desc = "[P]roject treeview" })

vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")

vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Open diagnostic [Q]uickfix list" })

vim.keymap.set("n", "<left>", '<cmd>echo "Use h to move!!"<CR>')
vim.keymap.set("n", "<right>", '<cmd>echo "Use l to move!!"<CR>')
vim.keymap.set("n", "<up>", '<cmd>echo "Use k to move!!"<CR>')
vim.keymap.set("n", "<down>", '<cmd>echo "Use j to move!!"<CR>')

vim.keymap.set("n", "<C-h>", "<C-w><C-h>", { desc = "Move focus to the left window" })
vim.keymap.set("n", "<C-l>", "<C-w><C-l>", { desc = "Move focus to the right window" })
vim.keymap.set("n", "<C-j>", "<C-w><C-j>", { desc = "Move focus to the lower window" })
vim.keymap.set("n", "<C-k>", "<C-w><C-k>", { desc = "Move focus to the upper window" })

vim.keymap.set("n", "K", vim.lsp.buf.hover, { silent = true })
