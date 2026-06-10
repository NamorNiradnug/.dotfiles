" for nvim-colorizer
set termguicolors

set completeopt=menu,menuone,noselect,preview
set updatetime=300
set foldmethod=expr
set foldexpr=nvim_treesitter#foldexpr()

set mouse=a

let g:neoformat_enabled_nim = ['nimpretty']
let g:neoformat_enabled_javascript = ['clang-format']
let g:neoformat_enabled_lua = ['stylua']

let g:vim_markdown_math = 1

function AutoSave()
    if &ma && &mod
        silent! update
        if &mod
            echo "Cannot save" @%
        endif
    endif
endfunction

au InsertLeave,TextChanged * nested call AutoSave()

lua << EOF
require 'colorizer'.setup({''}, { css = true })

require 'onedark'.setup {
    style = "deep",
    transparent = true,
    highlights = {
        Folded = {fg = "$grey", fmt = "bold"},
        Error = {fg = "$none"}, --, fmt = "undercurl", sp = "$red"},
        Macro = {fg = "$purple"},
        WinSeparator = {fg = "$fg"},
        MatchParen = {bg = "$bg2", fmt = "bold"},
        NvimTreeVertSplit = {fg = "$fg"},
        NvimTreeGitModifiedIcon = {fg = "$yellow"},
        NvimTreeGitNewIcon = {fg = "$green"},
        NvimTreeGitDirtyIcon = {fg = "$yellow"},
        NvimTreeGitMergeIcon = {fg = "$yellow"},
        DiagnosticVirtualTextError = {fg = "$red"},
        DiagnosticVirtualTextHint = {fg = "$purple"},
        DiagnosticVirtualTextInfo = {fg = "$cyan"},
        DiagnosticVirtualTextWarn = {fg = "$yellow"},
        FloatBorder = {fg = "$blue", bg = "$none"},
        NormalFloat = {fg = "$fg", bg = "$none"},
        LspSignatureActiveParameter = {bg = "$grey", fmt = "underline"},
        Special = {fg = "$red", fmt = "bold"},
        SpecialChar = {fg = "$red", fmt = "bold"},
        StatusLine = {fg = "$fg", bg = "$none"},
        StatusLineNC = {fg = "$fg", bg = "$none"},
        StatusLineTerm = {fg = "$fg", bg = "$none"},
        StatusLineTermNC = {fg = "$fg", bg = "$none"},
        TabLineFill = {fg = "$fg", bg = "$none"},
        CursorLine = {bg = "$none"},
        CursorLineNr = {fg = "$orange", fmt = "bold"},
        User1 = {fg = "$bg0", bg = "$fg", fmt = "bold"},
        SignatureHint = {fg = "$fg", fmt = "bold"},
        cInclude = {fg = "$purple"},
        StorageClass = {fg = "$purple"},
        WinBar = {bg = "$none"},
        WinBarNC = {bg = "$none"},

        hsNewtypedef = {fg = "$purple"},
        hsStructure = {fg = "$purple"},

        ["@variable"] = {fg = "$red"},
        ["@error"] = {fg = "$fg"}, -- fmt = "undercurl", sp = "$red"},
        ["@macro"] = {fg = "$purple"},
        ["@variable.builtin"] = {fmt = "italic"},
        ["@type.builtin"] = {fg = "$yellow"},
        ["@type.qualifier"] = {fg = "$purple"},
        ["@type.definition"] = {fg = "$yellow"},
        ["@storageclass"] = {fg = "$purple"},
        ["@punctuation.special.typst"] = {fg = "$orange"},
        ["@lsp.type.property.cpp"] = {fg = "$cyan"},
        ["@lsp.type.variable"] = {fg = "$red"},
        ["@lsp.type.concept.cpp"] = {fg = "$yellow"},
        ["@lsp.mod.readonly"] = {fg = "$orange"},
        ["@lsp.typemod.variable.readonly"] = {fg = "$red"},
        ["@lsp.mod.constant"] = {fg = "$orange"},
        ["@lsp.typemod.variable.constant"] = {fg = "$orange"},
        ["@lsp.typemod.variable.defaultLibrary"] = {fg = "$none"},
        ["@lsp.typemod.keyword"] = {fg = "$purple"},
        ["@lsp.typemod.parameter"] = {fg = "$red"},
        ["@lsp.typemod.method.readonly.cpp"] = {fg = "$blue"},
        ["@lsp.typemod.property.readonly"] = {fg = "$cyan"},
    },
    diagnostics = {
        background = false,
    }
}

require 'lsp_signature'.setup({
    hint_prefix = "   ",
    always_trigger = true,
    hint_scheme = "SignatureHint",
    select_signature_key = '<A-n>'
})

require 'nvim-autopairs'.setup()

vim.api.nvim_create_autocmd('FileType', {
    pattern = { 'cpp', 'c', 'rust', 'python', 'haskell', 'html', 'js', 'markdown', 'lua', 'vim', 'sh', 'bash', 'fish', 'meson', 'json', 'make', 'cmake', 'ninja' },
    callback = function() vim.treesitter.start() end,
})

require("lean").setup({ mappings = true })
require("typst-preview").setup({
    invert_colors = "auto",
    dependencies_bin = {
        tinymist = "/usr/bin/tinymist",
        websocat = "/usr/bin/websocat",
    }
})
EOF

autocmd BufRead,BufNewFile *.S set filetype=gas
autocmd BufRead,BufNewFile *.html call jinja#AdjustFiletype()

autocmd FileType markdown set wrap linebreak

autocmd FileType css :ColorizerToggle
autocmd FileType css :highlight clear TSError
