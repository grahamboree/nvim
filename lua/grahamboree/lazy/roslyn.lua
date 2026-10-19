return {
    -- C# via the Roslyn language server (what VS Code and Visual Studio use).
    -- Install the server with :MasonInstall roslyn-language-server.
    "seblyng/roslyn.nvim",
    ft = "cs",
    opts = {
        -- search parent directories for a solution, useful for Unity
        -- projects opened from a subfolder
        broad_search = true,
    },
}
