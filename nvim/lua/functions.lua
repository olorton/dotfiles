-- Used by lightline to show the char code under the cursor
-- TODO why is the status in lightline working when this function is broken?
vim.cmd([[
    function! LightlineCharcode() abort
        let line = getline('.')
        let col = col('.')
        return "ASdf"
        -- return col - 1 < len(line) ? printf('0x%02x', char2nr(matchstr(line[(col - 1):], '^.'))) : '----'
    endfunction
]])
