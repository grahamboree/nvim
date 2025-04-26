local utils = {}

function utils.nremap(...) vim.keymap.set('n', ...) end
function utils.vremap(...) vim.keymap.set('v', ...) end

function utils.getVisualText()
    local function shouldSwap(startLine, endLine, startCol, endCol)
        if startLine > endLine then return true end
        return startLine == endLine and startCol > endCol
    end

    local _, startLine, startCol, _ = table.unpack(vim.fn.getpos("v"))
    local _, endLine, endCol, _ = table.unpack(vim.fn.getpos("."))

    -- Because you can highlight moving backwards or forwards
    if shouldSwap(startLine, startCol, endLine, endCol) then
        -- swap
        startLine, endLine = endLine, startLine
        startCol, endCol = endCol, startCol
    end

    local lines = vim.fn.getline(startLine, endLine)
    if #lines == 0 then return end

    -- trim to the selected text
    lines[#lines] = string.sub(lines[#lines], 1, endCol)
    lines[1] = string.sub(lines[1], startCol)

    return table.concat(lines, '\n')
end

return utils
