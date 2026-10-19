return {
    -- Completion. Replaces nvim-cmp.
    "saghen/blink.cmp",
    version = "1.*", -- release tag, so the prebuilt fuzzy matcher is downloaded
    dependencies = { "folke/lazydev.nvim" },
    event = "InsertEnter",
    opts = {
        keymap = {
            -- Enter accepts, Up/Down select, C-Space opens, C-e cancels,
            -- C-k toggles signature help, C-b/C-f scroll docs.
            preset = "enter",
            -- Tab accepts too (old nvim-cmp habit), then jumps snippet tabstops.
            ["<Tab>"] = { "select_and_accept", "snippet_forward", "fallback" },
        },
        completion = {
            documentation = { auto_show = true, auto_show_delay_ms = 200 },
            list = { selection = { preselect = true, auto_insert = false } },
        },
        signature = { enabled = true },
        sources = {
            default = { "lazydev", "lsp", "path", "snippets", "buffer" },
            providers = {
                lazydev = {
                    name = "LazyDev",
                    module = "lazydev.integrations.blink",
                    score_offset = 100, -- show Neovim API results first in Lua
                },
            },
        },
        fuzzy = { implementation = "prefer_rust_with_warning" },
    },
    opts_extend = { "sources.default" },
}
