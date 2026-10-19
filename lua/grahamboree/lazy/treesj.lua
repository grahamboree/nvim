return {
    'Wansmer/treesj',
    dependencies = { 'nvim-treesitter/nvim-treesitter' },
    keys = {
        { '<leader>j', function() require('treesj').toggle() end, desc = 'Split/join node' },
        { '<leader>J', function() require('treesj').toggle({ split = { recursive = true } }) end, desc = 'Split/join node (recursive)' },
    },
    opts = { use_default_keymaps = false },
}
