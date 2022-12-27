colorscheme onedark

set number
set splitbelow
set tabstop=4
set shiftwidth=4
set expandtab

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


lua << EOF
function treesitter_statusline()
    -- return require'nvim-treesitter'.statusline({
    --     type_patterns = {
    --         'function', 'method', 'struct', "class",
    --         "interface", "table", "namespace",
    --         "if_statement", "for_statement", "for_in_statement", "while_statement", "for_range_loop",
    --         "if_condition", "variable"
    --     },
    --     separator = "  "
    -- })
    return require"nvim-navic".get_location()
end
EOF

const filename_block = Block('%f%m%r%h%w%q')
const pos_block = Block('%l:%c')

const statuslinestr = "━" .. filename_block .. "━%=" .. pos_block .. "━"

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
autocmd VimEnter * nested call OnStartup()
