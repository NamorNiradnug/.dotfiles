colorscheme onedark

set number
set splitbelow
set tabstop=4
set shiftwidth=4
set expandtab

set guicursor+=c:ver100-iCursor

function OnStartup()
    split
    if winheight(0) > 15
        :resize 15
    endif
    set winfixheight
    :term
    set nonumber
    NvimTreeToggle
    autocmd BufWinEnter,WinEnter term://* startinsert
endfunction

" spawn terminal on startup
autocmd VimEnter * call OnStartup()
