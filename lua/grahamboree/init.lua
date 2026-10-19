require("grahamboree.set")
require("grahamboree.remap")
require("grahamboree.lazy_init")

local autocmd = vim.api.nvim_create_autocmd

-- highlight yanked text briefly
autocmd("TextYankPost", {
    pattern = "*",
    callback = function()
        vim.hl.on_yank({
            higroup = "IncSearch",
            timeout = 150,
        })
    end,
})

-- trim trailing whitespace on save
autocmd("BufWritePre", {
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
        vim.keymap.set("n", "<leader>lg", vim.lsp.buf.definition, vim.tbl_extend("force", opts, { desc = "Go to definition" }))
        vim.keymap.set("n", "K", vim.lsp.buf.hover, vim.tbl_extend("force", opts, { desc = "Hover" }))
        vim.keymap.set("n", "<leader>lws", vim.lsp.buf.workspace_symbol, vim.tbl_extend("force", opts, { desc = "Workspace symbols" }))
        vim.keymap.set("n", "<leader>lca", vim.lsp.buf.code_action, vim.tbl_extend("force", opts, { desc = "Code action" }))
        -- done in telescope instead...
        --vim.keymap.set("n", "<leader>lrr", function() vim.lsp.buf.references() end, opts)
        vim.keymap.set("n", "<leader>lrn", vim.lsp.buf.rename, vim.tbl_extend("force", opts, { desc = "Rename symbol" }))
        --vim.keymap.set("i", "<leader>lh", function() vim.lsp.buf.signature_help() end, opts)

        -- Diagnostics
        vim.keymap.set("n", "<leader>ld", vim.diagnostic.open_float, vim.tbl_extend("force", opts, { desc = "Line diagnostics" }))
        vim.keymap.set("n", "]d", function() vim.diagnostic.jump({ count = 1, float = true }) end, vim.tbl_extend("force", opts, { desc = "Next diagnostic" }))
        vim.keymap.set("n", "[d", function() vim.diagnostic.jump({ count = -1, float = true }) end, vim.tbl_extend("force", opts, { desc = "Previous diagnostic" }))

        -- Inlay hints (enable by default, toggle with <leader>lh)
        local client = vim.lsp.get_client_by_id(e.data.client_id)
        if client and client:supports_method("textDocument/inlayHint") then
            vim.lsp.inlay_hint.enable(true, { bufnr = e.buf })
        end
        vim.keymap.set("n", "<leader>lh", function()
            vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = e.buf }), { bufnr = e.buf })
        end, vim.tbl_extend("force", opts, { desc = "Toggle inlay hints" }))
    end
})

-- file type aliases
vim.filetype.add({
    extension = {
        jenkins = "groovy",
        bytes = "yaml",
        hlsl = "hlsl",
        hlsli = "hlsl",
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
