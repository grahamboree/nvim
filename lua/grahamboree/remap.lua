local utils = require("grahamboree.utils")

-- NetRW
vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)

-- keep cursor position when joining lines
vim.keymap.set("n", "J", "mzJ`z")

-- center scroll when using half and full page jumps
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "<C-f>", "<C-d><C-d>zz") -- hack
vim.keymap.set("n", "<C-b>", "<C-u><C-u>zz") -- hack

-- center scroll on search result and highlight it
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

-- keep cursor position when reindenting paragraph
vim.keymap.set("n", "=ap", [[ma=ap'a]])

-- yank to system clipboard
vim.keymap.set({ "n", "v" }, "<leader>y", '"+y')
vim.keymap.set("n", "<leader>Y", '"+Y')

-- paste without overwriting default register
vim.keymap.set("x", "<leader>p", '"_dP')

-- delete line without clearing default register
vim.keymap.set({ "n", "v" }, "<leader>d", '"_d')

-- format with the current lsp
vim.keymap.set("n", "<leader>f", vim.lsp.buf.format)

-- quick search and replace for word under cursor
vim.keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/<Left>]])

-- buffer swapping
vim.keymap.set("n", "<Tab>", "<cmd>bnext<cr>")
vim.keymap.set("n", "<S-Tab>", "<cmd>bprevious<cr>")

-- quick macro execute, instead of Ex mode which is useless
vim.keymap.set("n", "Q", "@q")

-- error navigation to mimic Rider
vim.keymap.set("n", "<leader>v", vim.diagnostic.goto_next)
vim.keymap.set("n", "<leader>c", vim.diagnostic.goto_prev)

-- Change ctrl+w o to toggle between maximizing a window
-- Reduces pain of accidentally hitting it
vim.keymap.set("n", "<C-W>O", utils.maximize_toggle)
vim.keymap.set("n", "<C-W>o", utils.maximize_toggle)
vim.keymap.set("n", "<C-W><C-O>", utils.maximize_toggle)

vim.keymap.set("n", "<Leader>a", utils.alt_file_switcher)

