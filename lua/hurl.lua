local api = vim.api

local M = {}

local function has_value(tab, val)
    for _, value in ipairs(tab) do if value == val then return true end end
    return false
end

local function validate(path)
    if vim.fn.executable("hurl") == 0 then
        api.nvim_err_writeln("hurl: command not found")
    end

    -- trim and get the full path
    path = string.gsub(path, "%s+", "")
    path = string.gsub(path, "\"", "")
    path = path == "" and "%" or path
    path = vim.fn.expand(path)
    path = vim.fn.fnamemodify(path, ":p")
    local file_exists = vim.fn.filereadable(path) == 1

    -- check if file exists
    if not file_exists then
        api.nvim_err_writeln("file does not exists")
        return
    end

    local ext = vim.fn.fnamemodify(path, ":e")
    if not has_value({"hurl"}, ext) then
        api.nvim_err_writeln("not a hurl script")
        return
    end

    return path
end

local function exec_hurl(path)
    vim.cmd('vsplit')
    local win = api.nvim_get_current_win()
    local buf = api.nvim_create_buf(false, true)
    api.nvim_win_set_buf(win, buf)
    api.nvim_buf_set_option(buf, "bufhidden", "wipe")

    vim.fn.termopen(string.format("%s %s", "hurl", vim.fn.shellescape(path)))
end

function M.hurl(file)
    local path = validate(file)
    if path == nil then return end
    exec_hurl(path)
end

return M
