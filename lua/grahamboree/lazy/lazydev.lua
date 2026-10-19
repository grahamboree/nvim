return {
    -- Full Neovim and plugin type information for lua_ls when editing Lua.
    "folke/lazydev.nvim",
    ft = "lua",
    opts = {
        library = {
            -- load luvit types when the `vim.uv` word is found
            { path = "${3rd}/luv/library", words = { "vim%.uv" } },
        },
    },
}
