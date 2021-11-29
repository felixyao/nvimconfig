-- auto complete and souce code detect

local _M = {}

_M.setup_cmp = function()
    local cmp = require'cmp'

    cmp.setup({
        snippet = {
            expand = function(args)
                vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
            end,
        },
        mapping = {
            ['<C-d>'] = cmp.mapping(cmp.mapping.scroll_docs(-4), { 'i', 'c' }),
            ['<C-f>'] = cmp.mapping(cmp.mapping.scroll_docs(4), { 'i', 'c' }),
            ['<C-Space>'] = cmp.mapping(cmp.mapping.complete(), { 'i', 'c' }),
            ['<C-y>'] = cmp.config.disable, -- Specify `cmp.config.disable` if you want to remove the default `<C-y>` mapping.
            ['<C-e>'] = cmp.mapping({
                            i = cmp.mapping.abort(),
                            c = cmp.mapping.close(),
                        }),
            ['<CR>'] = cmp.mapping.confirm({ select = true }),
        },
        sources = cmp.config.sources({
            { name = 'nvim_lsp' },
            { name = 'vsnip' }, -- For vsnip users.
            }, {
            { name = 'buffer' },
        })
    })
    -- Use buffer source for `/` (if you enabled `native_menu`, this won't work anymore).
    cmp.setup.cmdline('/', {
        sources = {
            { name = 'buffer' }
         }
    })
    -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
    cmp.setup.cmdline(':', {
        sources = cmp.config.sources({
            { name = 'path' }
        }, {
            { name = 'cmdline' }
        })
    })
end
local servers = {
    sumneko_lua = function(lspconfig, capabilities)
            --lua server :
        local settings = require('local_settings')
        if string.len(settings.lsp_sumneko_root_path) == 0  or string.len(settings.lsp_sumneko_binary) == 0 then
            return
        end
        local sumneko_root_path = settings.lsp_sumneko_root_path
        local sumneko_binary = settings.lsp_sumneko_binary
        local lsp_config = {
            cmd = {sumneko_binary, '-E', sumneko_root_path..'/main.lua'},
            capabilities = capabilities,
            setting = {
                Lua = { runtime = {version = 'LuaJIT', path = vim.split(package.path, ';')}},
                diagnostics = {globals = {'vim'}},
                workspace = {
                    libary = {[vim.fn.expand('$VIMRUNTIME/lua')] = true,
                              [vim.fn.expand('$VIMRUNTIME/lua/vim/lsp')] = true},
                    preloadFileSize = 450
                }
            }
        }
        lspconfig.sumneko_lua.setup(lsp_config)
    end,

    erlangls = function(lspconfig, capabilities)
        --erlang_ls server :
        local lsp_config = {
            capabilities = capabilities,
            cmd = {"erlang_ls", "--transport", "stdio"};
        }
        lspconfig.erlangls.setup(lsp_config )
    end,
}
_M.setup = function()
    local signs = {Error = " ", Warn = " ", Hint = " ", Info = " "}

    for type, icon in pairs(signs) do
	    local hl = "DiagnosticSign" .. type
	    vim.fn.sign_define(hl, {text = icon, texthl = hl, numhl = ""})
	end

--	Show icons in autocomplete
    require('vim.lsp.protocol').CompletionItemKind = {
    '', '', 'ƒ', ' ', '', '', '', 'ﰮ', '', '', '', '', '了', ' ', '﬌ ', ' ', ' ', '', ' ', ' ',
    ' ', ' ', '', '', '<>'
    }

    vim.lsp.handlers['textDocument/publishDiagnostics'] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
        underline = true,
        virtual_text = {spacing = 5, severity_limit = 'Warning'},
        update_in_insert = true
    })
   local lspconfig = require('lspconfig')
   local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())
   capabilities.textDocument.completion.completionItem.snippetSupport = true
   for _, prop in pairs(servers) do
       prop(lspconfig, capabilities)
   end
end
return _M

