return {
    "nvim-telescope/telescope.nvim",
    tag = "0.1.5",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-tree/nvim-web-devicons"
    },
    config = function()
        require("telescope").setup {
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
                }
            }
        }

        local builtin = require("telescope.builtin")
        local utils = require("grahamboree.utils")

        vim.keymap.set("n", "<leader>pf", builtin.find_files)
        vim.keymap.set("n", "<leader>pg", builtin.live_grep)
        vim.keymap.set("n", "<leader>vh", builtin.help_tags)
        vim.keymap.set("n", "<leader>g", function()
            builtin.live_grep { default_text = vim.fn.expand("<cword>") }
        end)
        vim.keymap.set("v", "<leader>g", function()
            builtin.live_grep { default_text = utils.get_visual_text() }
        end)
    end
}
