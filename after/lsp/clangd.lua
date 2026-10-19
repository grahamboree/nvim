-- Merged over nvim-lspconfig's clangd defaults (see :h lsp-config). Lives in
-- after/ so it is applied after the plugin's own lsp/clangd.lua and wins.

-- Compilers clangd may ask for include paths. Globs, so no exact install
-- path is needed.
local query_driver = jit.os == "Windows"
    and "--query-driver=**/cl.exe,**/clang-cl.exe,**/clang++.exe,**/g++.exe"
    or "--query-driver=/usr/bin/c++,/usr/bin/cc,/usr/bin/clang,/usr/bin/clang++"

return {
    cmd = {
        "clangd",
        "--background-index",
        "--clang-tidy",
        "--header-insertion=iwyu",
        "--completion-style=detailed",
        "--function-arg-placeholders",
        query_driver,
        "--inlay-hints=true",
    },
}
