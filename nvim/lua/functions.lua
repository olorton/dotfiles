-- Used by lightline to show the char code under the cursor
vim.cmd([[
    function! LightlineCharcode() abort
        let line = getline('.')
        let col = col('.')
        return col - 1 < len(line) ? printf('0x%02x', char2nr(matchstr(line[(col - 1):], '^.'))) : '----'
    endfunction
]])
