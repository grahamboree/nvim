return {
    'nvim-telescope/telescope.nvim',
    dependencies = {
        'nvim-lua/plenary.nvim',
        {
            'nvim-telescope/telescope-fzf-native.nvim',
            -- no prebuilt binaries; make on Unix, cmake + MSVC build tools on Windows
            build = jit.os == 'Windows'
                and 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release --target install'
                or 'make',
        },
    },
    -- Loaded on first use: any key below, :Telescope, or a require() of a
    -- telescope module (lazy.nvim handles the last one, e.g. from utils.lua).
    cmd = "Telescope",
    keys = {
        { "<leader>pf", function() require("telescope.builtin").find_files() end, desc = "Find files" },
        { "<leader>pb", function() require("telescope.builtin").buffers() end, desc = "Buffers" },
        { "<leader>pg", function() require("telescope.builtin").live_grep() end, desc = "Live grep" },
        { "<leader>ph", function() require("telescope.builtin").help_tags() end, desc = "Help tags" },
        { "<leader>/", function() require("telescope.builtin").current_buffer_fuzzy_find() end, desc = "Fuzzy find in buffer" },
        {
            "<leader>g",
            function() require("telescope.builtin").live_grep { default_text = vim.fn.expand("<cword>") } end,
            desc = "Grep word under cursor",
        },
        {
            "<leader>g",
            function() require("telescope.builtin").live_grep { default_text = require("grahamboree.utils").get_visual_text() } end,
            mode = "v",
            desc = "Grep selection",
        },
        { "<leader>lrr", function() require("telescope.builtin").lsp_references() end, desc = "References" },
        { "<leader>ls", function() require("telescope.builtin").lsp_document_symbols() end, desc = "Document symbols" },
        { "<leader>lws", function() require("telescope.builtin").lsp_dynamic_workspace_symbols() end, desc = "Workspace symbols" },
    },
    config = function()
        local telescope = require("telescope")
        telescope.setup {
            defaults = {
                file_ignore_patterns = {
                    "node_modules",
                    "%.git/",
                    "Engine/",       -- for Spirit Crossing
                    "Intermediate/", -- for Spirit Crossing
                    "venv/",
                    ".venv/",
                    "build/",
                    "dist/",
                    "obj/",
                    "__pycache__/",
                    "%.meta$",
                }
            }
        }
        -- use the native fzf sorter for all pickers
        telescope.load_extension("fzf")
    end
}
