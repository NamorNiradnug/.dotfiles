-- completion
local icons = {
    Class = "ﴯ ",
    Color = " ",
    Constant = " ",
    Constructor = " ",
    Enum = " ",
    EnumMember = " ",
    Event = " ",
    Interface = " ",
    Field = " ",
    File = " ",
    Folder = " ",
    Function = " ",
    Keyword = " ",
    Method = "ƒ ",
    Module = " ",
    Operator = " ",
    Property = "ﰠ ",
    Reference = " ",
    Snippet = "﬌ ",
    Struct = " ",
    Text = " ",
    TypeParameter = " ",
    Unit = " ",
    Value = " ",
    Variable = " ",
}

local cmp = require 'cmp'
local luasnip = require 'luasnip'

luasnip.config.setup({
    enable_autosnippets = true
})

require("luasnip.loaders.from_vscode").lazy_load()

local has_words_before = function()
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

cmp.setup({
    snippet = {
        expand = function(args)
            luasnip.lsp_expand(args.body)
        end
    },
    mapping = cmp.mapping.preset.insert({
        ['<CR>'] = cmp.mapping.confirm({ select = true }),
        ['<Right>'] = cmp.mapping.confirm({ select = false }),
        ['<Esc>'] = cmp.mapping.abort(),
        ['<C-Up>'] = cmp.mapping.scroll_docs(-2),
        ['<C-Down>'] = cmp.mapping.scroll_docs(2),
        ['<Tab>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_next_item()
            elseif has_words_before() then
                cmp.complete()
            else
                fallback()
            end
        end, { "i", "s" }),
        ['<C-Tab>'] = cmp.mapping.complete(),
    }),
    sources = cmp.config.sources({
        { name = 'nvim_lsp' },
        { name = 'luasnip' },
        { name = 'buffer' },
    }),
    formatting = {
        format = function(entry, vim_item)
            -- Kind icons
            vim_item.kind = string.format('%s %s', icons[vim_item.kind], vim_item.kind) -- This concatonates the icons with the name of the item kind
            -- Source
            vim_item.menu = ({
                buffer = "[Buffer]",
                nvim_lsp = "[LSP]",
                luasnip = "[LuaSnip]",
                nvim_lua = "[Lua]",
                latex_symbols = "[LaTeX]",
                vsnip = "[vsnip]"
            })[entry.source.name]
            return vim_item
        end
    },
    window = {
        completion = cmp.config.window.bordered(),
        documentation = cmp.config.window.bordered(),
    },
    experimental = { ghost_text = true },
})

-- insert braces on autocompletion
local cmp_autopairs = require('nvim-autopairs.completion.cmp')
cmp.event:on('confirm_done', cmp_autopairs.on_confirm_done({map_char = {tex = ''}}))

-- general
local lspconfig = require 'lspconfig'

local border = {
      {"╭", "FloatBorder"},
      {"─", "FloatBorder"},
      {"╮", "FloatBorder"},
      {"│", "FloatBorder"},
      {"╯", "FloatBorder"},
      {"─", "FloatBorder"},
      {"╰", "FloatBorder"},
      {"│", "FloatBorder"},
}

-- LSP settings (for overriding per client)
--local handlers =  {
--    ["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = border }),
--    ["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = border }),
--    ["textDocument/documentSymbol"] = vim.lsp.with(vim.lsp.handlers.document_symbol, { border = border }),
--}

-- To instead override globally
local orig_util_open_floating_preview = vim.lsp.util.open_floating_preview
function vim.lsp.util.open_floating_preview(contents, syntax, opts, ...)
    opts = opts or {}
    opts.border = border
    return orig_util_open_floating_preview(contents, syntax, opts, ...)
end

local on_attach = function(_, bufnr)
    local opts = { buffer = bufnr }
    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
    vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
    vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)
    vim.keymap.set('n', '<C-d>', vim.lsp.buf.type_definition, opts)
    vim.keymap.set('n', '<F12>', vim.lsp.buf.rename, opts)
    vim.keymap.set('n', '<C-l>', vim.lsp.buf.code_action, {})
    vim.keymap.set('n', '<C-f>', vim.lsp.buf.formatting, {})
    vim.keymap.set('i', '<C-f>', vim.lsp.buf.formatting, {})
    vim.api.nvim_create_user_command("Format", vim.lsp.buf.formatting, {})
    vim.api.nvim_command("highlight clear TSError")
    vim.api.nvim_create_autocmd("CursorHold", {
        buffer = bufnr,
        callback = function()
            local opts = {
                focusable = false,
                close_events = { "BufLeave", "CursorMoved", "InsertEnter", "FocusLost" },
                border = 'rounded',
                source = 'always',
                prefix = ' ',
                scope = 'cursor',
            }
        vim.diagnostic.open_float(nil, opts)
        end
    })
end

local signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }
for type, icon in pairs(signs) do
    local hl = "DiagnosticSign" .. type
    vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end

vim.diagnostic.config({
    virtual_text = {
        prefix = '❮',
    },
    update_in_insert = true
})

require"clangd_extensions".setup {
    server = {
        on_attach = function(_, bufnr)
            on_attach(_, bufnr)
            vim.keymap.set('n', '<F2>', function() vim.api.nvim_command("ClangdSwitchSourceHeader") end)
        end,
        handlers = handlers,
        cmd = { "clangd", "--header-insertion=never", "--completion-style=detailed", "--clang-tidy" }
    }
}

--lspconfig.ccls.setup  { on_attach = on_attach, handlers = handlers, init_options = { cache = { directory = ".ccls-cache" } } }
lspconfig.pylsp.setup { on_attach = on_attach, handlers = handlers }
lspconfig.nimls.setup { on_attach = on_attach, handlers = handlers }
lspconfig.quick_lint_js.setup { on_attach = on_attach, handlers = handlers }

