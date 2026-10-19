return {
    'nvim-telescope/telescope.nvim',
    dependencies = {
        'nvim-lua/plenary.nvim',
        { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
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

        local builtin = require("telescope.builtin")
        local utils = require("grahamboree.utils")
        local map = vim.keymap.set

        map("n", "<leader>pf", builtin.find_files, { desc = "Find files" })
        map("n", "<leader>pb", builtin.buffers, { desc = "Buffers" })
        map("n", "<leader>pg", builtin.live_grep, { desc = "Live grep" })
        map("n", "<leader>ph", builtin.help_tags, { desc = "Help tags" })
        map("n", "<leader>/", builtin.current_buffer_fuzzy_find, { desc = "Fuzzy find in buffer" })
        map("n", "<leader>g", function()
            builtin.live_grep { default_text = vim.fn.expand("<cword>") }
        end, { desc = "Grep word under cursor" })
        map("v", "<leader>g", function()
            builtin.live_grep { default_text = utils.get_visual_text() }
        end, { desc = "Grep selection" })
        map("n", "<leader>lrr", builtin.lsp_references, { desc = "References" })
    end
}
