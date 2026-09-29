local gh = function(x)
    return "https://github.com/" .. x
end

vim.pack.add({
    -- LSP and related
    gh("neovim/nvim-lspconfig"),
    gh("hrsh7th/nvim-cmp"),
    gh("hrsh7th/cmp-nvim-lsp"),
    gh("ray-x/lsp_signature.nvim"),
    gh("p00f/clangd_extensions.nvim"),

    -- Languages support
    gh("nvim-treesitter/nvim-treesitter"),
    gh("simrat39/rust-tools.nvim"),
    gh("Julian/lean.nvim"),
    gh("chomosuke/typst-preview.nvim"),

    -- Just useful stuff
    gh("nvim-lua/plenary.nvim"),
    gh("nvim-telescope/telescope.nvim"),
    gh("sbdchd/neoformat"),
    gh("alvan/vim-closetag"),
    gh("windwp/nvim-autopairs"),

    -- Look and feel
    gh("navarasu/onedark.nvim"),
    gh("kyazdani42/nvim-web-devicons"),
    gh("SmiteshP/nvim-navic"),
})

require("onedark").setup({
    style = "deep",
    transparent = true,
    highlights = {
        Folded = { fg = "$grey", fmt = "bold" },
        Error = { fg = "$none" }, --, fmt = "undercurl", sp = "$red"},
        Macro = { fg = "$purple" },
        WinSeparator = { fg = "$fg" },
        MatchParen = { bg = "$bg2", fmt = "bold" },
        NvimTreeVertSplit = { fg = "$fg" },
        NvimTreeGitModifiedIcon = { fg = "$yellow" },
        NvimTreeGitNewIcon = { fg = "$green" },
        NvimTreeGitDirtyIcon = { fg = "$yellow" },
        NvimTreeGitMergeIcon = { fg = "$yellow" },
        DiagnosticVirtualTextError = { fg = "$red" },
        DiagnosticVirtualTextHint = { fg = "$purple" },
        DiagnosticVirtualTextInfo = { fg = "$cyan" },
        DiagnosticVirtualTextWarn = { fg = "$yellow" },
        FloatBorder = { fg = "$blue", bg = "$none" },
        NormalFloat = { fg = "$fg", bg = "$none" },
        LspSignatureActiveParameter = { bg = "$grey", fmt = "underline" },
        Special = { fg = "$red", fmt = "bold" },
        SpecialChar = { fg = "$red", fmt = "bold" },
        StatusLine = { fg = "$fg", bg = "$none" },
        StatusLineNC = { fg = "$fg", bg = "$none" },
        StatusLineTerm = { fg = "$fg", bg = "$none" },
        StatusLineTermNC = { fg = "$fg", bg = "$none" },
        TabLineFill = { fg = "$fg", bg = "$none" },
        CursorLine = { bg = "$none" },
        CursorLineNr = { fg = "$orange", fmt = "bold" },
        User1 = { fg = "$bg0", bg = "$fg", fmt = "bold" },
        SignatureHint = { fg = "$fg", fmt = "bold" },
        cInclude = { fg = "$purple" },
        StorageClass = { fg = "$purple" },
        WinBar = { bg = "$none" },
        WinBarNC = { bg = "$none" },

        hsNewtypedef = { fg = "$purple" },
        hsStructure = { fg = "$purple" },

        ["@variable"] = { fg = "$red" },
        ["@error"] = { fg = "$fg" }, -- fmt = "undercurl", sp = "$red"},
        ["@macro"] = { fg = "$purple" },
        ["@variable.builtin"] = { fmt = "italic" },
        ["@type.builtin"] = { fg = "$yellow" },
        ["@type.qualifier"] = { fg = "$purple" },
        ["@type.definition"] = { fg = "$yellow" },
        ["@storageclass"] = { fg = "$purple" },
        ["@punctuation.special.typst"] = { fg = "$orange" },
        ["@lsp.type.property.cpp"] = { fg = "$cyan" },
        ["@lsp.type.variable"] = { fg = "$red" },
        ["@lsp.type.concept.cpp"] = { fg = "$yellow" },
        ["@lsp.mod.readonly"] = { fg = "$orange" },
        ["@lsp.typemod.variable.readonly"] = { fg = "$red" },
        ["@lsp.mod.constant"] = { fg = "$orange" },
        ["@lsp.typemod.variable.constant"] = { fg = "$orange" },
        ["@lsp.typemod.variable.defaultLibrary"] = { fg = "$none" },
        ["@lsp.typemod.keyword"] = { fg = "$purple" },
        ["@lsp.typemod.parameter"] = { fg = "$red" },
        ["@lsp.typemod.method.readonly.cpp"] = { fg = "$blue" },
        ["@lsp.typemod.property.readonly"] = { fg = "$cyan" },
    },
    diagnostics = {
        background = false,
    },
})

require("lsp_signature").setup({
    hint_enable = false,
})

require("nvim-autopairs").setup()

vim.g.lean_config = { mappings = true }

vim.g.neoformat_enabled_nim = { "nimpretty" }
vim.g.neoformat_enabled_javascript = { "clang-format" }
vim.g.neoformat_enabled_lua = { "stylua" }

vim.g.vim_markdown_math = true

require("typst-preview").setup({
    invert_colors = "auto",
    dependencies_bin = {
        tinymist = "/usr/bin/tinymist",
        websocat = "/usr/bin/websocat",
    },
})

vim.api.nvim_create_autocmd("FileType", {
    pattern = {
        "cpp",
        "c",
        "rust",
        "python",
        "haskell",
        "html",
        "js",
        "markdown",
        "lua",
        "vim",
        "sh",
        "bash",
        "fish",
        "meson",
        "json",
        "make",
        "cmake",
        "ninja",
    },
    callback = function()
        vim.treesitter.start()
        vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
    end,
})
