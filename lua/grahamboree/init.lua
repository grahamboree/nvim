require("grahamboree.set")
require("grahamboree.remap")
require("grahamboree.lazy_init")

local autocmd = vim.api.nvim_create_autocmd

-- highlight yanked text briefly
autocmd("TextYankPost", {
    pattern = "*",
    callback = function()
        vim.highlight.on_yank({
            higroup = "IncSearch",
            timeout = 40,
        })
    end,
})

-- trim trailing whitespace on save
autocmd({ "BufWritePre" }, {
    pattern = "*",
    command = [[let save_cursor = getpos(".") | %s/\s\+$//e | call setpos(".", save_cursor)]],
})

-- Auto p4 edit for read-only files
vim.api.nvim_create_autocmd("FileChangedRO", {
    pattern = "*",
    callback = function()
        local file_path = vim.fn.expand("%")
        local result = vim.fn.system("p4 edit " .. vim.fn.shellescape(file_path))

        if vim.v.shell_error == 0 then
            -- Success
            vim.notify("File checked out: " .. file_path, vim.log.levels.INFO)
            -- Reload the buffer to apply the new permissions
            vim.cmd("edit!")
            return true -- Indicate that the readonly state has been handled
        else
            -- Failed
            vim.notify("Failed to checkout file: " .. result, vim.log.levels.ERROR)
            return false
        end
    end,
    desc = "Automatically run p4 edit on read-only files",
})

-- LSP keybinds
autocmd("LspAttach", {
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
    virtual_text = true,      -- Show inline text
    signs = true,             -- Show signs in the gutter
    underline = true,         -- Underline the problematic code
    update_in_insert = false, -- Don't update while typing
    severity_sort = true,     -- Show errors above warnings etc.
})

vim.cmd.colorscheme("catppuccin-mocha")
