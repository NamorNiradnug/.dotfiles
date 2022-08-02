" for nvim-colorizer
set termguicolors

set completeopt=menu,menuone,noselect,preview
set updatetime=500
set foldmethod=syntax
set foldtext=getline(v:foldstart).'\ ...\ '.trim(getline(v:foldend))
set fillchars=fold:\ 
set list
set listchars=trail:•,tab:»\ 

set mouse=a

let g:presence_auto_update = 1

let g:neoformat_enabled_nim = ['nimpretty']
let g:neoformat_enabled_javascript = ['clang-format']

lua << EOF
require 'autosave'.setup {
        enabled = true,
        execution_message = "AutoSave: saved at " .. vim.fn.strftime("%H:%M:%S"),
        events = {"InsertLeave", "TextChanged"},
        conditions = {
            exists = false,
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
                corner = "╰",
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
    git = {
        enable = true,
    }
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

require 'onedark'.setup {
    style = "deep",
    transparent = true,
    highlights = {
        Folded = {fg = "$grey", fmt = "bold"},
        Error = {fg = "$fg", fmt = "undercurl", sp = "$red"},
        TSError = {fg = "$fg", fmt = "undercurl", sp = "$red"},
        Macro = {fg = "$purple"},
        VertSplit = {fg = "$bg3"},
        NvimTreeVertSplit = {fg = "$bg3"},
        DiagnosticVirtualTextError = {fg = "$red"},
        DiagnosticVirtualTextHint = {fg = "$purple"},
        DiagnosticVirtualTextInfo = {fg = "$cyan"},
        DiagnosticVirtualTextWarn = {fg = "$yellow"},
        FloatBorder = {fg = "$blue", bg = "$none"},
        NormalFloat = {fg = "$fg", bg = "$none"},
        TSVariable = {fg = "$red"},
        Special = {fg = "$red", fmt = "bold"},
        SpecialChar = {fg = "$red", fmt = "bold"},
   },
    diagnostics = {
        background = false,
    }
}

require 'nvim-autopairs'.setup()
require("presence"):setup({
    auto_update         = true,
    neovim_image_text   = "The One True Text Editor",
    main_image          = "neovim",
    client_id           = "793271441293967371",
    log_level           = nil,
    debounce_timeout    = 10,
    enable_line_number  = false,
    blacklist           = {},
    buttons             = true,
    file_assets         = {},

    editing_text        = "Editing %s",
    file_explorer_text  = "Browsing %s",
    git_commit_text     = "Committing changes",
    plugin_manager_text = "Managing plugins",
    reading_text        = "Reading %s",
    workspace_text      = "Working on %s",
    line_number_text    = "Line %s out of %s",
})

EOF

autocmd BufRead,BufNewFile *.html call jinja#AdjustFiletype()

autocmd FileType css :ColorizerToggle
autocmd FileType css :highlight clear TSError

