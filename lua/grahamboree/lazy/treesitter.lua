return {
    {
        "nvim-treesitter/nvim-treesitter",
        lazy = false,
        build = ":TSUpdate",
        config = function()
            --[[
            local ts = require('nvim-treesitter')
            ts.setup {
                install_dir = vim.fn.stdpath('data') .. '/site',
            }

            ts.install {
                "vimdoc",
                "javascript",
                "typescript",
                "c",
                "lua",
                "jsdoc",
                "bash",
                "markdown",
                "markdown_inline",
            }:wait(300000)

            --]]
            vim.wo.foldmethod = 'expr'
            vim.wo.foldexpr = 'v:lua.vim.treesitter.foldexpr()'

            vim.api.nvim_create_autocmd("FileType", {
                callback = function(args)
                    pcall(vim.treesitter.start, args.buf)
                end,
            })
        end
    },

    {
        "nvim-treesitter/nvim-treesitter-context",
        config = function()
            require('treesitter-context').setup {
                enable = true,
                multiwindow = false,
                max_lines = 0,
                min_window_height = 0,
                line_numbers = true,
                multiline_threshold = 20,
                trim_scope = 'outer',
                mode = 'cursor',
                separator = nil,
                zindex = 20,
                on_attach = nil,
            }
        end
    }
}
