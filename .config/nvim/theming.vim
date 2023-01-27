colorscheme onedark

set number
set splitbelow
set tabstop=4
set shiftwidth=4
set expandtab
set scrolloff=10

set foldtext=getline(v:foldstart).'\ ...\ '.trim(getline(v:foldend))
set fillchars=fold:\ ,stl:━,stlnc:━,vert:┃
set display+=lastline
set list
set listchars=trail:•,tab:»\ ,leadmultispace:┊\ \ \ ,extends:…,precedes:…
set nowrap
set whichwrap+=<,>,h,l

augroup CursorLine
    au VimEnter,WinEnter,BufWinEnter * setlocal cursorline
    au WinLeave * setlocal nocursorline
augroup END

function Block(s)
    if type(a:s) == 1 && len(a:s) != 0
        return '%#User1#' .. a:s .. '%*'
    else
        return ""
    endif
endfunction

const filename_block = Block('%f%m%r%h%w%q')
const pos_block = Block('%l:%c')

const statuslinestr = "━" .. filename_block .. "━%=" .. pos_block .. "━"

set statusline=%{%&ft=='NvimTree'?'%=':statuslinestr%}

set guicursor+=c:ver100-iCursor

function OnStartup()
    let winid = win_getid()
    split
    if winheight(0) > 15
        :resize 15
    endif
    set winfixheight
    :wincmd J
    :term
    " :NvimTreeToggle
    call win_gotoid(winid)
    autocmd BufWinEnter,WinEnter term://* startinsert
endfunction

autocmd TermOpen * setlocal statusline=━%{%Block('\ '..b:term_title)%} | set nomodified | set nonumber | set nobuflisted
autocmd VimEnter * nested call OnStartup()
