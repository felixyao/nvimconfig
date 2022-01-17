# nvimconfig my personal nvim configuation

## Intall

- clone the repo into your .config folder 
```bash
cd ~/.config
git clone https://github.com/felixyao/nvimconfig.git
mv nvimconfig nvim
```

- create your local settings file

There are some external binary is used by nvim (language servers mainly). So I create this file to specify where those binaries are located.  
```bash
cd nvim/lua
cp example_local_settings.lua local_settings.lua
```
The file look like this:
```lua
_M = {
    lsp_sumneko_root_path = "/home/efenyao/.tools/3rd/lua-language-server/bin/Linux", --lua language server
    lsp_sumneko_binary = '/home/efenyao/.tools/3rd/lua-language-server/bin/Linux/lua-language-server' --lua language server binary
}

return _M
```
You can left the keys as empty string to disable the lsp function.

- Start nvim and install plugins

    - start nvim
    - type ":PackerSync"

- restart nvim and enjoy it!

## Install language servers

language servers are needed for nvim lsp feature. lsp will provide some very useful programming language feature such goto definition, find all references
I recommanded to use them but it is not mandatory. 


General language server guide could see [here](https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md)  
And I mainly use these:
- [lua](https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#sumneko_lua)
- [python](https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#pyright)
- [yaml](https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#yamlls)
- [erlang](https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#erlangls)
- [html](https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#html)
- [jsonls](https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#jsonls)
- [cssls](https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#cssls)
- [cssmodules_ls](https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#cssmodules_ls)
- [vuels](https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#vuels)




