return {
    -- Indent guides with the current scope highlighted.
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    event = { "BufReadPost", "BufNewFile" },
    opts = {
        indent = { char = "▏" },
        scope = { show_start = false, show_end = false },
        exclude = {
            filetypes = { "help", "lazy", "mason", "oil", "trouble", "checkhealth" },
        },
    },
}
