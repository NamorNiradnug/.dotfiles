" for nvim-colorizer
set termguicolors

set completeopt=menu,menuone,noselect

set foldmethod=syntax
set foldtext=getline(v:foldstart).'\ ...\ '.trim(getline(v:foldend))
set fillchars=fold:\ 
set list
set listchars=trail:•,tab:»\ 

set mouse=a

let g:presence_auto_update = 1

let g:neoformat_python_autopep8 = {
            \ 'exe': 'autopep8',
            \ 'args': ['-s 4', '-E', '--max-line-length 120'],
            \ 'replace': 1,
            \ 'stdin': 1, 
            \ 'env': ["DEBUG=1"],
            \ 'valid_exit_codes': [0, 23],
            \ 'no_append': 1,
            \ }

let g:neoformat_enabled_python = ['autopep8']
let g:neoformat_enabled_nim = ['nimpretty']
let g:neoformat_enabled_javascript = ['clang-format']

let g:nvim_tree_git_hl = 1
let g:nvim_tree_highlight_opened_files = 1

lua << EOF
require 'autosave'.setup {
        enabled = true,
        execution_message = "AutoSave: saved at " .. vim.fn.strftime("%H:%M:%S"),
        events = {"InsertLeave", "TextChanged"},
        conditions = {
            exists = true,
            filename_is_not = {},
            filetype_is_not = {},
            modifiable = true
        },
        write_all_buffers = false,
        on_off_commands = true,
        clean_command_line_interval = 0,
        debounce_delay = 135
}

require 'nvim-treesitter.configs'.setup {
    highlight = {
        enable = true,
        additional_vim_regex_highlighting = true,
    },
    indent = {
        enable = true,
        disable = {"cpp", "c"}
    }
}

require 'colorizer'.setup({''}, { css = true })

require 'nvim-tree'.setup {
    hijack_cursor = true,
    renderer = {
        indent_markers = {
            enable = true,
            icons = {
                corner = "└ ",
                edge = "│ ",
                none = "  ",
            }
        }
    },
    diagnostics = {
        enable = true,
        show_on_dirs = true,
        icons = {
            hint = " ",
            info = " ",
            warning = " ",
            error = " ",
        },
    },
}

require 'bufferline'.setup {
    offsets = {
        {
            filetype = "NvimTree",
            text = "File Explorer",
            highlight = "Directory",
            text_align = "left"
        }
    }
}

EOF

autocmd BufRead,BufNewFile *.html call jinja#AdjustFiletype()
autocmd BufRead,BufNewFile *.html let b:AutoPairs = {'<!--' : '-->', '{%' : '%}', '{{' : '}}'}

autocmd FileType css :ColorizerToggle

