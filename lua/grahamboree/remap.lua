local utils = require("grahamboree.utils")
local map = vim.keymap.set

-- NetRW
map("n", "<leader>pv", vim.cmd.Ex, { desc = "File explorer" })

-- clear search highlight
map("n", "<Esc>", "<cmd>nohlsearch<cr>", { desc = "Clear search highlight" })

-- keep cursor position when joining lines
map("n", "J", "mzJ`z", { desc = "Join lines (keep cursor)" })

-- center scroll when using half and full page jumps
map("n", "<C-d>", "<C-d>zz")
map("n", "<C-u>", "<C-u>zz")
map("n", "<C-f>", "<C-d><C-d>zz") -- hack
map("n", "<C-b>", "<C-u><C-u>zz") -- hack

-- center scroll on search result and highlight it
map("n", "n", "nzzzv")
map("n", "N", "Nzzzv")

-- keep cursor position when reindenting paragraph
map("n", "=ap", [[ma=ap'a]], { desc = "Reindent paragraph (keep cursor)" })

-- yank to system clipboard
map({ "n", "v" }, "<leader>y", '"+y', { desc = "Yank to clipboard" })
map("n", "<leader>Y", '"+Y', { desc = "Yank line to clipboard" })

-- paste without overwriting default register
map("x", "<leader>p", '"_dP', { desc = "Paste (keep register)" })

-- delete line without clearing default register
map({ "n", "v" }, "<leader>d", '"_d', { desc = "Delete (keep register)" })

-- format with the current lsp
map("n", "<leader>f", vim.lsp.buf.format, { desc = "Format buffer" })

-- quick search and replace for word under cursor
map("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/<Left>]], { desc = "Replace word under cursor" })

-- buffer swapping
map("n", "<Tab>", "<cmd>bnext<cr>", { desc = "Next buffer" })
map("n", "<S-Tab>", "<cmd>bprevious<cr>", { desc = "Previous buffer" })

-- quick macro execute, instead of Ex mode which is useless
map("n", "Q", "@q", { desc = "Run macro q" })

-- error navigation to mimic Rider
map("n", "<leader>v", function() vim.diagnostic.jump({ count = 1, float = true }) end, { desc = "Next diagnostic" })
map("n", "<leader>c", function() vim.diagnostic.jump({ count = -1, float = true }) end, { desc = "Previous diagnostic" })

-- Change ctrl+w o to toggle between maximizing a window
-- Reduces pain of accidentally hitting it
map("n", "<C-W>O", utils.maximize_toggle, { desc = "Toggle maximize window" })
map("n", "<C-W>o", utils.maximize_toggle, { desc = "Toggle maximize window" })
map("n", "<C-W><C-O>", utils.maximize_toggle, { desc = "Toggle maximize window" })

map("n", "<Leader>a", utils.alt_file_switcher, { desc = "Switch source/header" })
