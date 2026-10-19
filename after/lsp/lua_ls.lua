-- Merged over nvim-lspconfig's lua_ls defaults. lazydev.nvim supplies the
-- Neovim runtime and plugin libraries on demand.
return {
    settings = {
        Lua = {
            diagnostics = {
                globals = { "vim", "it", "describe", "before_each", "after_each" },
            },
        },
    },
}
