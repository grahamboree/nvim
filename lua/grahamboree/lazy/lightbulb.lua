return {
    -- Gutter hint when a code action is available, like Rider's intention bulb.
    "kosayoda/nvim-lightbulb",
    event = "LspAttach",
    opts = {
        autocmd = { enabled = true },
        -- Above diagnostics (10-13) and gitsigns (6) so the bulb is never
        -- hidden on the cursor line.
        priority = 20,
        sign = {
            enabled = true,
            text = "💡",
            lens_text = "🔎",
        },
        action_kinds = {"quickfix"}
    },
}
