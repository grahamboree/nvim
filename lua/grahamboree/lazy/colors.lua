return {
    {
        "catppuccin/nvim",
        name = "catppuccin",
        priority = 1000,
        opts = {
            custom_highlights = function(colors)
                local U = require("catppuccin.utils.colors")
                -- Gutter git markers: same hues as the palette but blended
                -- toward the background so they do not compete with code
                -- action and diagnostic signs.
                local function muted(hex) return U.blend(hex, colors.base, 0.45) end
                return {
                    GitSignsAdd = { fg = muted(colors.green) },
                    GitSignsChange = { fg = muted(colors.blue) },
                    GitSignsDelete = { fg = muted(colors.red) },
                    GitSignsUntracked = { fg = muted(colors.green) },
                }
            end,
        },
    },
}
