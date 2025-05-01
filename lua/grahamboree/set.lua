vim.g.mapleader = " "

-- line numbers
vim.opt.number = true         -- line numbers
vim.opt.relativenumber = true -- relative line numbers

-- indenting
vim.opt.tabstop = 4        -- 4 space tabs
vim.opt.softtabstop = 4    -- 4 space tabs
vim.opt.shiftwidth = 4     -- 4 space tabs
vim.opt.expandtab = true   -- spaces rather than \t
vim.opt.smartindent = true -- indent things using basic syntax information

-- swap files and undo
vim.opt.swapfile = false                               -- Don't use swap files
vim.opt.backup = false                                 -- Don't keep backups of unsaved buffers
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir" -- Set undo history dir
vim.opt.undofile = true                                -- Use an undo file

-- searching
vim.opt.hlsearch = true   -- highlight search results
vim.opt.incsearch = true  -- show results as you type
vim.opt.ignorecase = true -- Make searching case insensitive.
vim.opt.smartcase = true  -- ... unless the query has capital letters.
vim.opt.gdefault = true   -- Use 'g' flag by default with :s/foo/bar/.
vim.opt.magic = true      -- Use 'magic' patterns (extended regular expressions).

-- colors
vim.opt.termguicolors = true

-- wrapping and columns
vim.opt.wrap = false      -- No line wrapping
vim.opt.scrolloff = 8     -- Keep the cursor at least 8 lines from the top or bottom of the window
vim.opt.signcolumn = "no" -- Don't draw the sign column unless necessary
vim.opt.textwidth = 0     -- Hard-wrap long lines as you type them.
vim.opt.linespace = 0     -- Set line-spacing to minimum.

-- UI/UX
vim.opt.updatetime = 50
vim.opt.showcmd = true     -- Show (partial) command in status line.
vim.opt.errorbells = false -- No beeps.
vim.opt.showmatch = true   -- Show matching brackets.
vim.opt.showmode = true    -- Show current mode.
vim.opt.ruler = true       -- Show the line and column numbers of the cursor.
vim.opt.cursorline = true  -- Highlight the cursor's line to make it easier to see.
vim.opt.modeline = true    -- Enable modeline.

-- folds and splits
vim.opt.foldlevel = 99
vim.opt.splitbelow = true -- Horizontal split below current.
vim.opt.splitright = true -- Vertical split to right of current.

-- netrw
vim.g.netrw_browse_split = 0
vim.g.netrw_banner = 0
vim.g.netrw_winsize = 25

-- text editing
vim.opt.joinspaces = false -- Prevents inserting two spaces after punctuation on a join (J).
--vim.opt.formatoptions = vim.opt.formatoptions + { 'o' }  -- Continue comment marker in new lines.

-- Ignore certain file patterns
local ignored = {
    "*.git/*",
    "*.so",
    "*.swp",
    "*.zip",
    "*.meta",
    "*.pyc",
    "*.o"
}
vim.opt.wildignore:append(table.concat(ignored, ","))

-- languages
vim.g.lua_syntax_fancynotequal = 1
