local api = vim.api

local M = {}

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

function M.close_window()
  api.nvim_win_close(win, true)
end

local function exec_hurl(path)
  -- window size
  local width = api.nvim_get_option("columns")
  local height = api.nvim_get_option("lines")
  local win_height = math.ceil(height * 0.5)
  local win_width = math.ceil(width * 0.5)
  local row = math.ceil(height - win_height)
  local col = math.ceil(width - win_width)
  
  local opts = {
    style = "minimal",
    relative = "editor",
    width = win_width,
    height = win_height,
    row = row,
    col = col,
    border = "rounded",
  }

  -- create preview buffer and set local options
  buf = api.nvim_create_buf(false, true)
  win = api.nvim_open_win(buf, true, opts)
  api.nvim_buf_set_option(buf, "bufhidden", "wipe")
  api.nvim_buf_set_option(buf, "filetype", "glowpreview")
  api.nvim_win_set_option(win, "winblend", 0)
  api.nvim_buf_set_keymap(buf, "n", "q", ":lua require('hurl').close_window()<cr>",
                          {noremap = true, silent = true})
  api.nvim_buf_set_keymap(buf, "n", "<Esc>", ":lua require('hurl').close_window()<cr>",
                          {noremap = true, silent = true})

  vim.fn.termopen(string.format("%s %s", "hurl", vim.fn.shellescape(path)))
end

function M.hurl(file)
  local current_win = vim.fn.win_getid()

  local path = validate(file)
  if path == nil then
    return
  end
  exec_hurl(file)
end

return M
