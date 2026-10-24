-- Show LSP code lenses (e.g. Roslyn reference counts) as end-of-line virtual
-- text instead of a virtual line above the symbol.
--
-- vim.lsp.codelens hard-codes `virt_lines_above = true` with no option to
-- change it, so this wraps nvim_buf_set_extmark and rewrites extmarks placed
-- in a code-lens namespace ("nvim.lsp.codelens:<client_id>"). Every other
-- extmark passes straight through.
local api = vim.api

-- ns_id -> boolean. Namespace ids are permanent, so caching is safe.
local is_codelens_ns = {}

local function codelens_ns(ns)
    local known = is_codelens_ns[ns]
    if known ~= nil then return known end

    known = false
    for name, id in pairs(api.nvim_get_namespaces()) do
        if id == ns then
            known = vim.startswith(name, "nvim.lsp.codelens:")
            break
        end
    end
    is_codelens_ns[ns] = known
    return known
end

local set_extmark = api.nvim_buf_set_extmark

api.nvim_buf_set_extmark = function(bufnr, ns, row, col, opts)
    if opts and opts.virt_lines_above and opts.virt_lines and codelens_ns(ns) then
        -- The first chunk is whitespace that indents the lens to the symbol's
        -- column; it is meaningless at end of line, so drop it.
        local chunks = opts.virt_lines[1] or {}
        local text = {}
        for i = 2, #chunks do
            text[#text + 1] = chunks[i]
        end

        opts = {
            virt_text = text,
            virt_text_pos = "eol",
            hl_mode = opts.hl_mode,
        }
    end
    return set_extmark(bufnr, ns, row, col, opts)
end
