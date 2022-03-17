"color scheme"

let g:onedark_config = {
	\ 'transparent': v:true,
    \ 'style': 'deep',
\ }

colorscheme onedark

set number
set splitbelow
set tabstop=4
set shiftwidth=4
set expandtab

function OnStartup()
    :split
    if winheight(0) > 15
        :resize 15
    endif
    :set winfixheight
    :term
    :NvimTreeToggle
    :autocmd BufWinEnter,WinEnter term://* startinsert
endfunction

" spawn terminal on startup
:autocmd VimEnter * call OnStartup()
