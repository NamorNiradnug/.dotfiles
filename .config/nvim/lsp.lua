-- completion
local icons = {
    Array = "[]",
    Class = " ",
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
    Key = " ",
    Keyword = " ",
    Method = "ƒ ",
    Module = " ",
    Namespace = " ",
    Null = "∅ ",
    Operator = " ",
    Property = "ﰠ ",
    Reference = " ",
    Snippet = "﬌ ",
    String = " ",
    Struct = " ",
    Text = " ",
    TypeParameter = " ",
    Unit = " ",
    Value = " ",
    Variable = " ",
}

local cmp = require("cmp")
local luasnip = require("luasnip")
local navic = require("nvim-navic")

luasnip.config.setup({
    enable_autosnippets = true,
})

require("luasnip.loaders.from_vscode").lazy_load()

navic.setup({
    icons = icons,
    highlight = true,
    separator = " > ",
    depth_limit = 0,
    depth_limit_indicator = "..",
    safe_output = true,
})

local has_words_before = function()
    local line, col = unpack(vim.api.nvim_win_get_cursor(0))
    return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

cmp.setup({
    snippet = {
        expand = function(args)
            luasnip.lsp_expand(args.body)
        end,
    },
    mapping = cmp.mapping.preset.insert({
        ["<CR>"] = cmp.mapping.confirm({ select = true }),
        ["<Right>"] = cmp.mapping.confirm({ select = false }),
        ["<Esc>"] = cmp.mapping.abort(),
        ["<C-Up>"] = cmp.mapping.scroll_docs(-2),
        ["<C-Down>"] = cmp.mapping.scroll_docs(2),
        ["<Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_next_item()
            elseif has_words_before() then
                cmp.complete()
            else
                fallback()
            end
        end, { "i", "s" }),
        ["<C-Tab>"] = cmp.mapping.complete(),
    }),
    sources = cmp.config.sources({
        { name = "nvim_lsp" },
        { name = "luasnip" },
        { name = "buffer" },
        { name = "nvim_lsp_signature_help" },
    }),
    formatting = {
        format = function(entry, vim_item)
            -- Kind icons
            vim_item.kind = string.format("%s %s", icons[vim_item.kind], vim_item.kind) -- This concatonates the icons with the name of the item kind
            -- Source
            vim_item.menu = ({
                buffer = "[Buffer]",
                nvim_lsp = "[LSP]",
                luasnip = "[LuaSnip]",
                nvim_lua = "[Lua]",
                latex_symbols = "[LaTeX]",
                vsnip = "[vsnip]",
            })[entry.source.name]
            return vim_item
        end,
    },
    window = {
        completion = cmp.config.window.bordered(),
        documentation = cmp.config.window.bordered(),
    },
    experimental = { ghost_text = true },
})

-- insert braces on autocompletion
local cmp_autopairs = require("nvim-autopairs.completion.cmp")
cmp.event:on(
    "confirm_done",
    cmp_autopairs.on_confirm_done({
        filetypes = {
            markdown = false,
        },
    })
)

-- general
local lspconfig = require("lspconfig")

-- Rounded borders
local orig_util_open_floating_preview = vim.lsp.util.open_floating_preview
function vim.lsp.util.open_floating_preview(contents, syntax, opts, ...)
    opts = opts or {}
    opts.border = "rounded"
    return orig_util_open_floating_preview(contents, syntax, opts, ...)
end

local on_attach = function(client, bufnr)
    local opts = { buffer = bufnr }
    vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
    vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
    vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
    vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
    vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, opts)
    vim.keymap.set("n", "<C-d>", vim.lsp.buf.type_definition, opts)
    vim.keymap.set("n", "<F12>", vim.lsp.buf.rename, opts)
    vim.keymap.set("n", "<C-l>", vim.lsp.buf.code_action, {})
    vim.keymap.set("n", "<C-f>", vim.lsp.buf.format, {})
    vim.keymap.set("i", "<C-f>", vim.lsp.buf.format, {})
    vim.api.nvim_create_user_command("Format", vim.lsp.buf.format, {})
    vim.api.nvim_command("highlight clear TSError")
    vim.api.nvim_create_autocmd("CursorHold", {
        buffer = bufnr,
        callback = function()
            local opts = {
                focusable = false,
                close_events = { "BufLeave", "CursorMoved", "InsertEnter", "FocusLost" },
                border = "rounded",
                source = "always",
                prefix = " ",
                scope = "cursor",
            }
            vim.diagnostic.open_float(nil, opts)
        end,
    })
    if client.server_capabilities.documentSymbolProvider then
        navic.attach(client, bufnr)
        vim.cmd("setlocal winbar=%{%v:lua.require'nvim-navic'.get_location()%}")
    end

    if client.server_capabilities.documentHighlightProvider then
        vim.api.nvim_create_augroup("lsp_document_highlight", {
            clear = false,
        })
        vim.api.nvim_clear_autocmds({
            buffer = bufnr,
            group = "lsp_document_highlight",
        })
        vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
            group = "lsp_document_highlight",
            buffer = bufnr,
            callback = vim.lsp.buf.document_highlight,
        })
        vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
            group = "lsp_document_highlight",
            buffer = bufnr,
            callback = vim.lsp.buf.clear_references,
        })
    end

    for _, method in ipairs({ 'textDocument/diagnostic', 'workspace/diagnostic' }) do
        local default_diagnostic_handler = vim.lsp.handlers[method]
        vim.lsp.handlers[method] = function(err, result, context, config)
            if err ~= nil and err.code == -32802 then
                return
            end
            return default_diagnostic_handler(err, result, context, config)
        end
    end
end

local signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }
for type, icon in pairs(signs) do
    local hl = "DiagnosticSign" .. type
    vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end

vim.diagnostic.config({
    virtual_text = {
        prefix = "❮",
    },
    update_in_insert = true,
})

require("rust-tools").setup({
    server = {
        on_attach = on_attach,
        handlers = handlers,
        settings = {
            ["rust-analyzer"] = {
                checkOnSave = {
                    command = "clippy",
                },
            },
        },
    },
})

require("clangd_extensions").setup({})

--[[
lspconfig.ccls.setup {
    on_attach = function(client, buf)
        on_attach(client, buf)
        vim.keymap.set('n', '<F2>', function()
            -- TODO Source/Header switch
        end)
    end,
    handlers = handlers,
    init_options = {
        cache = { directory = ".ccls-cache" },
        compilationDatabaseDirectory = "build",
    }
}
]]
--

lspconfig.clangd.setup({
    on_attach = function(client, bufnr)
        on_attach(client, bufnr)
        require("clangd_extensions.inlay_hints").setup_autocmd()
        require("clangd_extensions.inlay_hints").set_inlay_hints()
        vim.keymap.set("n", "<F2>", function()
            vim.api.nvim_command("ClangdSwitchSourceHeader")
        end)
    end,
    handlers = handlers,
    cmd = {
        -- "/home/roma57/.installed/llvm-project/build/bin/clangd",
        "/usr/bin/clangd",
        "--header-insertion=never",
        "--completion-style=detailed",
        "--clang-tidy",
        "--function-arg-placeholders",
        "--enable-config",
    },
})
lspconfig.pylsp.setup({
    on_attach = on_attach,
    handlers = handlers,
    python = {
        analysis = {
            ignore = { "*" },
        },
    },
})
lspconfig.ruff_lsp.setup({ on_attach = on_attach, handlers = handlers })
lspconfig.nimls.setup({ on_attach = on_attach, handlers = handlers })
lspconfig.quick_lint_js.setup({ on_attach = on_attach, handlers = handlers })
lspconfig.typst_lsp.setup({ on_attach = on_attach, handlers = handlers })
lspconfig.arduino_language_server.setup({
    cmd = {
        "arduino-language-server",
        "-cli-config",
        "~/.arduino15/arduino-cli.yaml",
        "-fqbn",
        "arduino:avr:uno",
        "-cli",
        "arduino-cli",
        -- "-clangd",
        -- "/home/roma57/.installed/llvm-project/build/bin/clangd",
    },
    on_attach = on_attach,
    handlers = handlers,
})
lspconfig.asm_lsp.setup({ on_attach = on_attach, handlers = handlers })
lspconfig.julials.setup({ on_attach = on_attach, handlers = handlers })
lspconfig.hls.setup({ on_attach = on_attach, handlers = handlers })
