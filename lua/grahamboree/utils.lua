local m = {}

function m.getVisualText()
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

local maximize_session = nil
local maximize_hidden_save = nil

function m.maximizeToggle()
  if maximize_session then
    vim.cmd('source ' .. vim.fn.fnameescape(maximize_session))

    -- delete the temp file
    vim.fn.delete(maximize_session)
    maximize_session = nil
    vim.o.hidden = maximize_hidden_save
    maximize_hidden_save = nil
  else
    maximize_hidden_save = vim.o.hidden
    maximize_session = vim.fn.tempname()
    vim.o.hidden = true
    vim.cmd('mksession! ' .. vim.fn.fnameescape(maximize_session))
    vim.cmd('only')
  end
end

return m
