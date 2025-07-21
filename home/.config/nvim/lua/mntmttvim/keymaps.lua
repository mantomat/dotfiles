local keymap = {}

keymap.init = function()
    vim.g.mapleader = " "
    vim.g.maplocalleader = " "

    -- Make navigation less horrible
    vim.keymap.set("n", "<C-d>", "<C-d>zz", { desc = "Center pointer when scrolling down" })
    vim.keymap.set("n", "<C-u>", "<C-u>zz", { desc = "Center pointer when scrolling up" })

    -- Let me open that netrw
    vim.keymap.set("n", "<Leader>p", "<cmd>Ex<CR>", { desc = "[P]roject treeview" })

    -- Why isn't this a default?
    vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>", { desc = "Disable search higlighting" })

    -- TODO see if lsp is still needed here
    vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Open diagnostic [Q]uickfix list" })

    -- Source Lua (useful for configuration)
    vim.keymap.set("n", "<leader><leader>x", "<cmd>Source %<CR>")
    vim.keymap.set("n", "<leader>x", ":.lua<CR>")
    vim.keymap.set("v", "<leader>x", ":lua<CR>")
end

keymap.lsp = function(lspAttachEvent)
    local map = function(keys, func, desc, mode)
        mode = mode or "n"
        vim.keymap.set(mode, keys, func, { buffer = lspAttachEvent.buf, desc = "LSP: " .. desc })
    end

    map("gd", require("telescope.builtin").lsp_definitions, "[G]oto [D]efinition")
    map("gr", require("telescope.builtin").lsp_references, "[G]oto [R]eferences")
    map("gI", require("telescope.builtin").lsp_implementations, "[G]oto [I]mplementation")
    map("<leader>D", require("telescope.builtin").lsp_type_definitions, "Type [D]efinition")
    map("<leader>ds", require("telescope.builtin").lsp_document_symbols, "[D]ocument [S]ymbols")
    map("<leader>ws", require("telescope.builtin").lsp_dynamic_workspace_symbols, "[W]orkspace [S]ymbols")
    map("<leader>r", vim.lsp.buf.rename, "[R]ename")
    map("<leader>a", vim.lsp.buf.code_action, "code [A]ction", { "n", "x" })
    map("gD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")

    -- The following code creates a keymap to toggle inlay hints in your
    -- code, if the language server you are using supports them
    --
    -- This may be unwanted, since they displace some of your code
    local client = vim.lsp.get_client_by_id(lspAttachEvent.data.client_id)
    if client and client.supports_method(vim.lsp.protocol.Methods.textDocument_inlayHint) then
        map("<leader>th", function()
            vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = lspAttachEvent.buf }))
        end, "[T]oggle Inlay [H]ints")
    end
end

keymap.harpoon = function()
    local harpoon = require("harpoon")

    local conf = require("telescope.config").values
    local function toggle_telescope(harpoon_files)
        local file_paths = {}
        for _, item in ipairs(harpoon_files.items) do
            table.insert(file_paths, item.value)
        end

        require("telescope.pickers")
            .new({}, {
                prompt_title = "Harpoon",
                finder = require("telescope.finders").new_table({
                    results = file_paths,
                }),
                previewer = conf.file_previewer({}),
                sorter = conf.generic_sorter({}),
            })
            :find()
    end

    vim.keymap.set("n", "<C-a>", function()
        harpoon:list():add()
    end)
    vim.keymap.set("n", "<C-e>", function()
        toggle_telescope(harpoon:list())
    end, { desc = "Open harpoon window" })

    -- Toggle previous & next buffers stored within Harpoon list
    vim.keymap.set("n", "<C-S-P>", function()
        harpoon:list():prev()
    end, { desc = "[P]revious Harpoon buffer" })
    vim.keymap.set("n", "<C-S-N>", function()
        harpoon:list():next()
    end, { desc = "[P]revious Harpoon buffer" })
end

keymap.telescope = function()
    local builtin = require("telescope.builtin")
    vim.keymap.set("n", "<leader>sh", builtin.help_tags, { desc = "[S]earch [H]elp" })
    vim.keymap.set("n", "<leader>sk", builtin.keymaps, { desc = "[S]earch [K]eymaps" })
    vim.keymap.set("n", "<leader>sf", builtin.find_files, { desc = "[S]earch [F]iles" })
    vim.keymap.set("n", "<leader>ss", builtin.builtin, { desc = "[S]earch [S]elect Telescope" })
    vim.keymap.set("n", "<leader>sw", builtin.grep_string, { desc = "[S]earch current [W]ord" })
    vim.keymap.set("n", "<leader>sg", builtin.live_grep, { desc = "[S]earch by [G]rep" })
    vim.keymap.set("n", "<leader>sd", builtin.diagnostics, { desc = "[S]earch [D]iagnostics" })
    vim.keymap.set("n", "<leader>sr", builtin.resume, { desc = "[S]earch [R]esume" })
    vim.keymap.set("n", "<leader>s.", builtin.oldfiles, { desc = '[S]earch Recent Files ("." for repeat)' })
    vim.keymap.set("n", "<leader><leader>", builtin.buffers, { desc = "[ ] Find existing buffers" })

    vim.keymap.set("n", "<leader>/", function()
        builtin.current_buffer_fuzzy_find(require("telescope.themes").get_dropdown({
            winblend = 10,
            previewer = false,
        }))
    end, { desc = "[/] Fuzzily search in current buffer" })

    vim.keymap.set("n", "<leader>s/", function()
        builtin.live_grep({
            grep_open_files = true,
            prompt_title = "Live Grep in Open Files",
        })
    end, { desc = "[S]earch [/] in Open Files" })

    vim.keymap.set("n", "<leader>sn", function()
        builtin.find_files({ cwd = vim.fn.stdpath("config") })
    end, { desc = "[S]earch [N]eovim files" })
end

return keymap
