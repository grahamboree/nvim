return {
    'nvim-telescope/telescope.nvim',
    tag = '0.1.5',
    dependencies = {
        'nvim-lua/plenary.nvim',
        'nvim-tree/nvim-web-devicons'
    },
    config = function()
        local builtin = require('telescope.builtin')
        require('telescope').setup({
            defaults = {
                file_ignore_patterns = {
                    "node_modules",
                    "%.git/",
                    "Engine/", -- for Spirit Crossing
                    "venv/",
                    ".venv/",
                    "build/",
                    "dist/",
                    "obj/",
                    "__pycache__/",
                }
            }
        })

        local utils = require('grahamboree.utils')
        utils.nremap('<leader>pf', builtin.find_files)
        utils.nremap('<leader>pg', builtin.live_grep)
        utils.nremap('<leader>vh', builtin.help_tags)
        utils.nremap('<leader>g', function() builtin.live_grep { default_text = vim.fn.expand('<cword>') } end)
        utils.vremap('<leader>g', function() builtin.live_grep { default_text = utils.getVisualText() } end)
    end
}
