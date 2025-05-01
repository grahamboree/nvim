local m = {}

function m.get_visual_text()
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

    return table.concat(lines, "\n")
end

local maximize_session = nil
local maximize_hidden_save = nil

function m.maximize_toggle()
    if maximize_session then
        vim.cmd("source " .. vim.fn.fnameescape(maximize_session))

        -- delete the temp file
        vim.fn.delete(maximize_session)
        maximize_session = nil
        vim.o.hidden = maximize_hidden_save
        maximize_hidden_save = nil
    else
        maximize_hidden_save = vim.o.hidden
        maximize_session = vim.fn.tempname()
        vim.o.hidden = true
        vim.cmd("mksession! " .. vim.fn.fnameescape(maximize_session))
        vim.cmd("only")
    end
end

function m.alt_file_switcher()
    local current_file = vim.api.nvim_buf_get_name(0)
    local filename = vim.fn.fnamemodify(current_file, ":t:r")
    local extension = vim.fn.fnamemodify(current_file, ":e")

    local glob = ""
    if (extension == "h" or extension == "hpp") then
        glob = string.format("**/%s.{c,cpp}", filename)
    else
        glob = string.format("**/%s.{h,hpp}", filename)
    end

    local files = vim.fn.glob(glob, false, true)

    if (#files == 0) then
        print("No alternate file found")
    elseif (#files == 1) then
        vim.cmd.edit(files[1])
    else
        -- Show a telescope picker to choose the appropriate file
        local pickers = require "telescope.pickers"
        local finders = require "telescope.finders"
        local conf = require("telescope.config").values
        local actions = require "telescope.actions"
        local action_state = require "telescope.actions.state"

        local opts = {}
        pickers.new(opts, {
            prompt_title = "Alternate File",
            finder = finders.new_table { results = files },
            previewer = conf.file_previewer(opts),
            sorter = conf.file_sorter(opts),
            attach_mappings = function(prompt_bufnr, map)
                actions.select_default:replace(function()
                    actions.close(prompt_bufnr)
                    local selection = action_state.get_selected_entry()
                    vim.cmd.edit(selection[1])
                end)
                return true
            end,
        }):find()
    end
end

return m
