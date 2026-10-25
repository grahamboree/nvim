return {
    -- Git gutter signs, hunk staging/preview and inline blame.
    "lewis6991/gitsigns.nvim",
    event = { "BufReadPre", "BufNewFile" },
    opts = {
        -- Thin bars instead of the default heavy ones.
        signs = {
            add = { text = "│" },
            change = { text = "│" },
            untracked = { text = "┊" },
        },
        signs_staged = {
            add = { text = "│" },
            change = { text = "│" },
        },
        current_line_blame_opts = { delay = 500 },
        on_attach = function(bufnr)
            local gs = require("gitsigns")
            local function map(mode, lhs, rhs, desc)
                vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, desc = desc })
            end

            -- Hunk navigation. In diff mode fall back to the built-in ]c / [c.
            map("n", "]c", function()
                if vim.wo.diff then return "]c" end
                vim.schedule(function() gs.nav_hunk("next") end)
                return "<Ignore>"
            end, "Next hunk")
            map("n", "[c", function()
                if vim.wo.diff then return "[c" end
                vim.schedule(function() gs.nav_hunk("prev") end)
                return "<Ignore>"
            end, "Previous hunk")

            map("n", "<leader>hs", gs.stage_hunk, "Stage hunk")
            map("n", "<leader>hr", gs.reset_hunk, "Reset hunk")
            map("v", "<leader>hs", function() gs.stage_hunk({ vim.fn.line("."), vim.fn.line("v") }) end, "Stage hunk")
            map("v", "<leader>hr", function() gs.reset_hunk({ vim.fn.line("."), vim.fn.line("v") }) end, "Reset hunk")
            map("n", "<leader>hS", gs.stage_buffer, "Stage buffer")
            map("n", "<leader>hR", gs.reset_buffer, "Reset buffer")
            map("n", "<leader>hu", gs.undo_stage_hunk, "Undo stage hunk")
            map("n", "<leader>hp", gs.preview_hunk, "Preview hunk")
            map("n", "<leader>hb", function() gs.blame_line({ full = true }) end, "Blame line")
            map("n", "<leader>hB", gs.toggle_current_line_blame, "Toggle inline blame")
            map("n", "<leader>hd", gs.diffthis, "Diff against index")
            map("n", "<leader>hD", function() gs.diffthis("~") end, "Diff against last commit")

            map({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>", "Select hunk")
        end,
    },
}
