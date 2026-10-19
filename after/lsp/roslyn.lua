-- Merged over roslyn.nvim's defaults. The server itself comes from
-- :MasonInstall roslyn-language-server (managed by mason-tool-installer).

-- Root of the dotnet install that the `dotnet` on PATH belongs to. Mason's
-- apphost otherwise finds a stale /usr/local/share/dotnet. Homebrew puts the
-- launcher in bin/ and the runtime in libexec/.
local function dotnet_root()
    if vim.env.DOTNET_ROOT then return vim.env.DOTNET_ROOT end
    local exe = vim.fn.resolve(vim.fn.exepath("dotnet"))
    if exe == "" then return nil end
    for _, dir in ipairs({ vim.fn.fnamemodify(exe, ":h"), vim.fn.fnamemodify(exe, ":h:h") .. "/libexec" }) do
        if vim.fn.isdirectory(dir .. "/shared/Microsoft.NETCore.App") == 1 then return dir end
    end
end

return {
    cmd_env = { DOTNET_ROOT = dotnet_root() },
    settings = {
        ["csharp|inlay_hints"] = {
            csharp_enable_inlay_hints_for_implicit_object_creation = true,
            csharp_enable_inlay_hints_for_implicit_variable_types = true,
            csharp_enable_inlay_hints_for_lambda_parameter_types = true,
            csharp_enable_inlay_hints_for_types = true,
            dotnet_enable_inlay_hints_for_parameters = true,
        },
        ["csharp|code_lens"] = {
            dotnet_enable_references_code_lens = true,
        },
        ["csharp|background_analysis"] = {
            dotnet_analyzer_diagnostics_scope = "openFiles",
            dotnet_compiler_diagnostics_scope = "openFiles",
        },
    },
}
