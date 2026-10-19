return {
    "nvim-treesitter/nvim-treesitter-textobjects",
    branch = "main",
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    config = function()
        require("nvim-treesitter-textobjects").setup({
            select = {
                lookahead = true, -- jump forward to the next object, like targets.vim
                selection_modes = {
                    ["@function.outer"] = "V",
                    ["@class.outer"] = "V",
                },
            },
            move = {
                set_jumps = true, -- movements go in the jumplist
            },
        })

        local select = require("nvim-treesitter-textobjects.select")
        local move = require("nvim-treesitter-textobjects.move")
        local swap = require("nvim-treesitter-textobjects.swap")
        local map = vim.keymap.set

        -- text objects: a<x> / i<x>
        local objects = {
            f = { "@function", "function" },
            c = { "@class", "class" },
            a = { "@parameter", "parameter" },
            i = { "@conditional", "conditional" },
            l = { "@loop", "loop" },
        }
        for key, obj in pairs(objects) do
            local query, name = obj[1], obj[2]
            map({ "x", "o" }, "a" .. key, function()
                select.select_textobject(query .. ".outer", "textobjects")
            end, { desc = "around " .. name })
            map({ "x", "o" }, "i" .. key, function()
                select.select_textobject(query .. ".inner", "textobjects")
            end, { desc = "inside " .. name })
        end

        -- movement
        map({ "n", "x", "o" }, "]f", function() move.goto_next_start("@function.outer", "textobjects") end, { desc = "Next function start" })
        map({ "n", "x", "o" }, "[f", function() move.goto_previous_start("@function.outer", "textobjects") end, { desc = "Previous function start" })
        map({ "n", "x", "o" }, "]F", function() move.goto_next_end("@function.outer", "textobjects") end, { desc = "Next function end" })
        map({ "n", "x", "o" }, "[F", function() move.goto_previous_end("@function.outer", "textobjects") end, { desc = "Previous function end" })
        map({ "n", "x", "o" }, "]]", function() move.goto_next_start("@class.outer", "textobjects") end, { desc = "Next class start" })
        map({ "n", "x", "o" }, "[[", function() move.goto_previous_start("@class.outer", "textobjects") end, { desc = "Previous class start" })

        -- swap parameters
        map("n", "]a", function() swap.swap_next("@parameter.inner") end, { desc = "Swap with next parameter" })
        map("n", "[a", function() swap.swap_previous("@parameter.inner") end, { desc = "Swap with previous parameter" })
    end,
}
