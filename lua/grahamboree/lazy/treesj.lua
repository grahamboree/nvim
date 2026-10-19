return {
    'Wansmer/treesj',
    dependencies = { 'nvim-treesitter/nvim-treesitter' },
    config = function()
        local tsj = require('treesj')
        tsj.setup { use_default_keymaps = false }

        vim.keymap.set('n', '<leader>j', tsj.toggle, { desc = 'Split/join node' })
        vim.keymap.set('n', '<leader>J', function()
            tsj.toggle({ split = { recursive = true } })
        end, { desc = 'Split/join node (recursive)' })
    end,
}
