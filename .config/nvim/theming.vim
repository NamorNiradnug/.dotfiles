colorscheme onedark

set number
set splitbelow
set tabstop=4
set shiftwidth=4
set expandtab

set foldtext=getline(v:foldstart).'\ ...\ '.trim(getline(v:foldend))
set fillchars=fold:\ ,stl:━,stlnc:━,vert:┃
set list
set listchars=trail:•,tab:»\ 

augroup CursorLine
    au VimEnter,WinEnter,BufWinEnter * setlocal cursorline
    au WinLeave * setlocal nocursorline
augroup END

function Block(s)
    return '%1*' .. a:s .. '%*'
endfunction

const statuslinestr = "━%{%Block('%f%m%r%h%w%q')%}%=%{%Block('%l:%c')%}━"

set statusline=%{%&ft=='NvimTree'?'%=':statuslinestr%}

set guicursor+=c:ver100-iCursor

function OnStartup()
    split
    if winheight(0) > 15
        :resize 15
    endif
    set winfixheight
    :term
    NvimTreeToggle
    autocmd BufWinEnter,WinEnter term://* startinsert
endfunction

autocmd TermOpen * setlocal statusline=━%{%Block('\ '..b:term_title)%} | set nomodified | set nonumber | set nobuflisted
" spawn terminal on startup
autocmd VimEnter * nested call OnStartup()
