return {
    -- C# via the Roslyn language server (what VS Code and Visual Studio use).
    -- Install the server with :MasonInstall roslyn-language-server.
    "seblyng/roslyn.nvim",
    -- Load eagerly. When lazy-loaded on FileType, the plugin calls
    -- vim.lsp.enable() before lazy has applied `opts`, so the first solution
    -- lookup runs without choose_target, finds the targets ambiguous and
    -- starts a rootless client with no solution. lazy then re-fires FileType
    -- and a second, correct client starts; the first keeps reporting bogus
    -- diagnostics (e.g. every `using` unnecessary) from its misc-file view.
    lazy = false,
    opts = {
        -- Unity names the generated solution after the project folder, but
        -- renamed projects leave stale .sln files behind. With more than one
        -- candidate roslyn.nvim opens nothing and every file is analysed in
        -- isolation (no UnityEngine, every `using` looks unused). Prefer the
        -- folder-named solution, then the most recently generated one.
        choose_target = function(targets)
            for _, target in ipairs(targets) do
                local dir = vim.fs.dirname(target)
                if vim.fs.basename(target) == vim.fs.basename(dir) .. ".sln" then
                    return target
                end
            end

            local newest, newest_mtime = nil, -1
            for _, target in ipairs(targets) do
                local stat = vim.uv.fs_stat(target)
                if stat and stat.mtime.sec > newest_mtime then
                    newest, newest_mtime = target, stat.mtime.sec
                end
            end
            return newest
        end,
    },
}
