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

-- reload files changed outside Neovim (p4 sync, Unity, Unreal) as soon as
-- focus returns, instead of on the next write attempt. Scheduled because a
-- buffer cannot be reloaded while an autocmd is still running.
autocmd({ "FocusGained", "BufEnter", "TermClose" }, {
    pattern = "*",
    callback = function()
        vim.schedule(function()
            if vim.o.buftype == "" and vim.fn.mode() ~= "c" then vim.cmd("checktime") end
        end)
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

-- LSP keybinds. Neovim already provides K (hover), grn (rename), gra (code
-- action), grr (references), gri (implementation), grt (type definition),
-- gO (document symbols), <C-S> (signature help, insert) and <C-W>d
-- (line diagnostics), so only mappings without a built-in live here.
autocmd("LspAttach", {
    callback = function(e)
        local opts = { buffer = e.buf }
        vim.keymap.set("n", "<leader>lg", vim.lsp.buf.definition, vim.tbl_extend("force", opts, { desc = "Go to definition" }))
        vim.keymap.set("n", "<leader>lws", vim.lsp.buf.workspace_symbol, vim.tbl_extend("force", opts, { desc = "Workspace symbols" }))

        -- Diagnostics: like the built-in ]d / [d but also opens the float
        vim.keymap.set("n", "]d", function() vim.diagnostic.jump({ count = 1, float = true }) end, vim.tbl_extend("force", opts, { desc = "Next diagnostic" }))
        vim.keymap.set("n", "[d", function() vim.diagnostic.jump({ count = -1, float = true }) end, vim.tbl_extend("force", opts, { desc = "Previous diagnostic" }))

        local client = vim.lsp.get_client_by_id(e.data.client_id)

        -- Code lens (e.g. Roslyn reference counts). Neovim refreshes them
        -- itself once enabled; <leader>lc runs the one under the cursor.
        if client and client:supports_method("textDocument/codeLens") then
            vim.lsp.codelens.enable(true, { bufnr = e.buf })
            vim.keymap.set("n", "<leader>lc", vim.lsp.codelens.run, vim.tbl_extend("force", opts, { desc = "Run code lens" }))
        end

        -- Inlay hints (enable by default, toggle with <leader>lh)
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
