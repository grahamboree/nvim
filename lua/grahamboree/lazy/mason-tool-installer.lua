return {
    -- One list of everything Mason should keep installed: language servers
    -- and formatters alike. Installs anything missing on startup.
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    dependencies = { "williamboman/mason.nvim" },
    opts = {
        ensure_installed = {
            "lua-language-server",
            "clangd",
            "roslyn-language-server", -- C#, used by roslyn.nvim
            "stylua",                 -- Lua formatter, used by conform
        },
    },
}
