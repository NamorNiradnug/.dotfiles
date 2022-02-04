"tabs width is 4 spaces"
set tabstop=4
set shiftwidth=4
set expandtab

" for nvim-colorizer
set termguicolors

let g:presence_auto_update = 1

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
        enable = true
    }
}

require 'colorizer'.setup({'*'}, {css = true})
EOF


