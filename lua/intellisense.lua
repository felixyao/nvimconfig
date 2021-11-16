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
    -- -- Setup lspconfig.
    -- local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())
    -- -- Replace <YOUR_LSP_SERVER> with each lsp server you've enabled.
    -- require('lspconfig')['<YOUR_LSP_SERVER>'].setup {
    --     capabilities = capabilities
    -- }
end
local servers = {
    sumneko_lua = function(lspconfig, capabilities)
            --lua server :
        local sumneko_root_path = '/home/efenyao/local/bin/lua-language-server/bin/Linux'
        local sumneko_binary = sumneko_root_path .. '/lua-language-server'
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
}
_M.setup = function()
   local lspconfig = require('lspconfig')
   local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())
   capabilities.textDocument.completion.completionItem.snippetSupport = true
   for _, prop in pairs(servers) do
       prop(lspconfig, capabilities)
   end
end
return _M

