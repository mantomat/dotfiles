return {
    {
        dependencies = { 'nvim-tree/nvim-web-devicons' },
        'nvim-lualine/lualine.nvim',
        config = function()
            local custom_onedark = require("lualine.themes.onedark")
            custom_onedark.normal.c.bg = "#282C34"
            require("lualine").setup {
                options = {
                    theme = custom_onedark
                },
                sections = {
                    lualine_a = {'mode'},
                    lualine_b = {'branch', 'diff', 'diagnostics'},
                    lualine_c = {'filename'},
                    lualine_x = {},
                    lualine_y = {'encoding', 'fileformat', 'filetype'},
                    lualine_z = {'location'}
                },
            }
        end
    }
}
