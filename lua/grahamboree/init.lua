require("grahamboree.set")
require("grahamboree.remap")
require("grahamboree.lazy_init")

local autocmd = vim.api.nvim_create_autocmd

-- highlight yanked text briefly
autocmd('TextYankPost', {
    pattern = '*',
    callback = function()
        vim.highlight.on_yank({
            higroup = 'IncSearch',
            timeout = 40,
        })
    end,
})

-- trim trailing whitespace on save
autocmd({"BufWritePre"}, {
    pattern = "*",
    command = [[let save_cursor = getpos(".") | %s/\s\+$//e | call setpos('.', save_cursor)]],
})

-- LSP keybinds
autocmd('LspAttach', {
    callback = function(e)
        local opts = { buffer = e.buf }
        --vim.keymap.set("n", "<F12>", function() vim.lsp.buf.definition() end, opts)
        --vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end, opts)
        --vim.keymap.set("n", "<leader>ld", function() vim.diagnostic.open_float() end, opts)
        --vim.keymap.set("n", "<leader>lws", function() vim.lsp.buf.workspace_symbol() end, opts)
        --vim.keymap.set("n", "<leader>lca", function() vim.lsp.buf.code_action() end, opts)
        --vim.keymap.set("n", "<leader>lrr", function() vim.lsp.buf.references() end, opts)
        --vim.keymap.set("n", "<leader>lrn", function() vim.lsp.buf.rename() end, opts)
        --vim.keymap.set("i", "<leader>lh", function() vim.lsp.buf.signature_help() end, opts)
        --vim.keymap.set("n", "[d", function() vim.diagnostic.goto_next() end, opts)
        --vim.keymap.set("n", "]d", function() vim.diagnostic.goto_prev() end, opts)
    end
})

-- file type aliases
vim.filetype.add({
    extension = {
        jenkins = "groovy",
        bytes = "yaml"
    },
})

-- Diagnostics
vim.diagnostic.config({
  virtual_text = true,   -- Show inline text
  signs = true,          -- Show signs in the gutter
  underline = true,      -- Underline the problematic code
  update_in_insert = false,  -- Don't update while typing
  severity_sort = true,      -- Show errors above warnings etc.
})

vim.cmd.colorscheme("catppuccin-mocha")


