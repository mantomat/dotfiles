return {
    {
        "folke/which-key.nvim",
        event = "VeryLazy",
        opts = {
            triggers = {
                { "<leader>", mode = { "n", "v" } },
            }
        },
        config = function()
            require("mntconf.keymaps").whichkey()
        end
    }
}
