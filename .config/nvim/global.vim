" for nvim-colorizer
set termguicolors

set completeopt=menu,menuone,noselect,preview
set updatetime=500
set foldmethod=syntax

set mouse=a

let g:presence_auto_update = 1

let g:neoformat_enabled_nim = ['nimpretty']
let g:neoformat_enabled_javascript = ['clang-format']

function AutoSave()
    if &ma && &mod
        :update
        echo bufname() .. " saved at ".. strftime("%H:%M:%S")
    endif
endfunction

au InsertLeave,TextChanged * nested call AutoSave()

lua << EOF
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
                item = "├",
                edge = "│",
                none = " ",
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
    options = {
        numbers = "ordinal",
        indicator = {
            icon = " ",
            style = "none"
        },
        separator_style = {'┃', '┃'},
        diagnostics = "nvim_lsp",
        diagnostics_update_in_insert = true,
        diagnostics_indicator = function(count, level)
            local icon = level:match("error") and "  " or " "
            return " " .. icon .. count
        end,
        offsets = {
            {
                filetype = "NvimTree",
                text = "File Explorer",
                highlight = "Directory",
                text_align = "left",
                separator = "┃"
            }
        },
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
        VertSplit = {fg = "$fg"},
        NvimTreeVertSplit = {fg = "$fg"},
        DiagnosticVirtualTextError = {fg = "$red"},
        DiagnosticVirtualTextHint = {fg = "$purple"},
        DiagnosticVirtualTextInfo = {fg = "$cyan"},
        DiagnosticVirtualTextWarn = {fg = "$yellow"},
        FloatBorder = {fg = "$blue", bg = "$none"},
        NormalFloat = {fg = "$fg", bg = "$none"},
        TSVariable = {fg = "$red"},
        Special = {fg = "$red", fmt = "bold"},
        SpecialChar = {fg = "$red", fmt = "bold"},
        StatusLine = {fg = "$fg", bg = "$none"},
        StatusLineNC = {fg = "$fg", bg = "$none"},
        CursorLine = {bg = "$none"},
        CursorLineNr = {fg = "$orange", fmt = "bold"},

        User1 = {fg = "$bg0", bg = "$fg", fmt = "bold"},
    },
    diagnostics = {
        background = false,
    }
}

require 'nvim-autopairs'.setup()

require('presence'):setup({
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

