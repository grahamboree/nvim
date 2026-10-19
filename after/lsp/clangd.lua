-- Merged over nvim-lspconfig's clangd defaults (see :h lsp-config). Lives in
-- after/ so it is applied after the plugin's own lsp/clangd.lua and wins.
return {
    cmd = {
        "clangd",
        "--background-index",
        "--clang-tidy",
        "--header-insertion=iwyu",
        "--completion-style=detailed",
        "--function-arg-placeholders",
        "--query-driver=/usr/bin/c++,/usr/bin/cc,/usr/bin/clang,/usr/bin/clang++",
        "--inlay-hints=true",
    },
}
