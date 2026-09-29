set completeopt=menu,menuone,noselect,preview
set updatetime=300

set mouse=a

function AutoSave()
    if &ma && &mod
        silent! update
        if &mod
            echo "Cannot save" @%
        endif
    endif
endfunction

au InsertLeave,TextChanged * nested call AutoSave()

autocmd BufRead,BufNewFile *.html call jinja#AdjustFiletype()

autocmd FileType markdown set wrap linebreak

autocmd FileType css :ColorizerToggle
autocmd FileType css :highlight clear TSError
