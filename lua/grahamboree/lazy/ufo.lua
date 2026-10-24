return {
    -- LSP/treesitter folding that keeps folds open by default and can
    -- preview a closed fold. Replaces the treesitter foldexpr in set.lua.
    "kevinhwang91/nvim-ufo",
    dependencies = { "kevinhwang91/promise-async" },
    event = { "BufReadPost", "BufNewFile" },
    opts = {
        provider_selector = function()
            return { "treesitter", "indent" }
        end,
    },
    keys = {
        { "zR", function() require("ufo").openAllFolds() end,                desc = "Open all folds" },
        { "zM", function() require("ufo").closeAllFolds() end,               desc = "Close all folds" },
        { "zp", function() require("ufo").peekFoldedLinesUnderCursor() end, desc = "Peek fold" },
    },
}
