vim.cmd("command! -nargs=? -complete=file Hurl :lua require('hurl').hurl('<f-args>')")
