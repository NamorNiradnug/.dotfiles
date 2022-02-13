"color scheme"

let g:onedark_config = {
    \ 'transparent': v:true,  
\ }

colorscheme onedark

set number
set splitbelow

function OnStartup()
    :split
    if winheight(0) > 15
        :resize 15
        :set winfixheight
    end
    :term
    :NvimTreeToggle
endfunction

" spawn terminal on startup
:autocmd VimEnter * call OnStartup()

