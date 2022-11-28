vim.cmd [[
  augroup _auto_read
    autocmd!
    autocmd FocusGained,BufEnter * :silent! !
  augroup end
  set autoread

  augroup _auto_save
    autocmd!
    autocmd FocusLost,WinLeave,CursorHold * :silent! wall
  augroup end
  set autowrite
]]
