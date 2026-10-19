return {
    "neovim/nvim-lspconfig",
    dependencies = {
        "williamboman/mason.nvim",
        "williamboman/mason-lspconfig.nvim",
        "saghen/blink.cmp",
        "j-hui/fidget.nvim",
    },

    config = function()
        require("fidget").setup({
            notification = {
                override_vim_notify = true,
            },
        })

        -- Per-server configuration lives in after/lsp/<name>.lua
        -- (see :h lsp-config). mason-lspconfig v2 calls vim.lsp.enable() for
        -- every installed server, so those files are picked up on attach.
        -- after/ puts them last on the runtimepath, so they override the
        -- plugins' own lsp/ files.

        -- Shared across all servers: advertise blink.cmp's completion capabilities.
        vim.lsp.config("*", {
            capabilities = require("blink.cmp").get_lsp_capabilities(),
        })

        require("mason").setup()
        require("mason-lspconfig").setup({
            -- installs are handled by mason-tool-installer
            automatic_enable = {
                exclude = {
                    "roslyn_ls", -- roslyn.nvim starts the Roslyn server itself
                    "stylua",    -- a formatter run by conform, not wanted as an LSP
                },
            },
        })

        vim.diagnostic.config({
            float = {
                focusable = false,
                style = "minimal",
                border = "rounded",
                source = true,
                header = "",
                prefix = "",
            },
        })
    end,
}
