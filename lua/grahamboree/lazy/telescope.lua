return {
    'nvim-telescope/telescope.nvim',
    tag = '0.1.5',
    dependencies = {
        'nvim-lua/plenary.nvim',
        'nvim-tree/nvim-web-devicons'
    },
    config = function()
        require('telescope').setup{}
        local telescope = require('telescope.builtin')

        local utils = require('grahamboree.utils')
        utils.nremap('<leader>pf', telescope.find_files)
        utils.nremap('<leader>pg', telescope.live_grep)
        utils.nremap('<leader>vh', telescope.help_tags)
        utils.nremap('<leader>g', function() telescope.live_grep { default_text = vim.fn.expand('<cword>') } end)
        utils.vremap('<leader>g', function() telescope.live_grep { default_text = utils.getVisualText() } end)
        --utils.nremap('<leader>pWs', function() telescope.grep_string { search = vim.fn.expand('<cWORD>') } end)
    end
}
