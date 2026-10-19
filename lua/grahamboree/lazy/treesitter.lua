return {
    {
        "nvim-treesitter/nvim-treesitter",
        -- master is frozen; main is the rewrite this config targets (ts.install,
        -- ts.get_installed). Pin it so a fresh clone can't land on master.
        branch = "main",
        lazy = false,
        build = ":TSUpdate",
        config = function()
            local ts = require("nvim-treesitter")
            ts.setup({})

            -- Parsers to keep installed. Neovim bundles c, lua, vim, vimdoc,
            -- query, markdown and markdown_inline; the rest are installed here.
            local languages = {
                "bash",
                "c",
                "c_sharp",
                "cpp",
                "groovy",
                "hlsl",
                "json",
                "lua",
                "markdown",
                "markdown_inline",
                "python",
                "query",
                "toml",
                "vim",
                "vimdoc",
                "yaml",
            }

            local installed = ts.get_installed()
            local missing = vim.tbl_filter(function(lang)
                return not vim.tbl_contains(installed, lang)
            end, languages)
            if #missing > 0 then
                ts.install(missing)
            end

            -- Start treesitter highlighting for any buffer with a parser.
            vim.api.nvim_create_autocmd("FileType", {
                callback = function(args)
                    pcall(vim.treesitter.start, args.buf)
                end,
            })
        end,
    },

    {
        "nvim-treesitter/nvim-treesitter-context",
        config = function()
            require("treesitter-context").setup({
                enable = true,
                multiwindow = false,
                max_lines = 0,
                min_window_height = 0,
                line_numbers = true,
                multiline_threshold = 20,
                trim_scope = "outer",
                mode = "cursor",
                separator = nil,
                zindex = 20,
                on_attach = nil,
            })
        end,
    },
}
