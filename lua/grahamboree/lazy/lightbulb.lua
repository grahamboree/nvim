return {
    -- Gutter hint when a code action is available, like Rider's intention bulb.
    "kosayoda/nvim-lightbulb",
    event = "LspAttach",
    opts = {
        autocmd = { enabled = true },
        sign = { enabled = true, text = "󰌵" },
    },
}
