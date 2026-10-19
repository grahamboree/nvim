return {
    -- Formatting. Uses a dedicated formatter when one is configured for the
    -- filetype and falls back to the LSP otherwise, so <leader>f always does
    -- something. No format-on-save.
    "stevearc/conform.nvim",
    keys = {
        {
            "<leader>f",
            function() require("conform").format({ async = true }) end,
            mode = { "n", "v" },
            desc = "Format buffer or selection",
        },
    },
    opts = {
        formatters_by_ft = {
            lua = { "stylua" },             -- :MasonInstall stylua
            c = { "clang_format" },         -- brew install clang-format
            cpp = { "clang_format" },
            -- everything else (C#, Python, ...) formats through its LSP
        },
        default_format_opts = {
            lsp_format = "fallback",
        },
    },
}
