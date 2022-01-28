local basic = {}

basic.setup = function ()
    vim.cmd('noswapfile')
    vim.cmd('filetype plugin indent on')
    vim.o.shortmess = vim.o.shortmess .. 'c'
    vim.o.hidden = true
    vim.o.whichwrap = 'b,s,<,>,[,],h,l'
    vim.o.pumheight = 10
    vim.o.fileencoding = "utf-8"
    vim.o.cmdheight = 2
    vim.o.splitbelow = true
    vim.o.splitright = true
    vim.opt.termguicolors = true
    vim.o.conceallevel = 0
    vim.o.showtabline = 2
    vim.o.showmode = false
    vim.o.backup = false
    vim.o.writebackup = false
    vim.o.updatetime = 300
    vim.o.timeoutlen = 100
    vim.o.clipboard = "unnamedplus"
    vim.o.hlsearch = false
    vim.o.ignorecase = true
    vim.o.scrolloff = 3
    vim.o.sidescrolloff = 5
    vim.o.mouse = "a"

    vim.wo.wrap = false
    vim.wo.number = true
    vim.wo.cursorline = true
    vim.wo.signcolumn = "yes"

    vim.o.tabstop = 4
    vim.bo.tabstop = 4
    vim.o.softtabstop = 4
    vim.bo.softtabstop = 4
    vim.o.shiftwidth = 4
    vim.bo.shiftwidth = 4
    vim.o.autoindent = true
    vim.bo.autoindent = true
    vim.o.expandtab = true
    vim.bo.expandtab = true

    -- Disable various builtin plugins in Vim that bog down speed
    vim.g.loaded_matchparen = 1
    vim.g.loaded_matchit = 1
    vim.g.loaded_logiPat = 1
    vim.g.loaded_rrhelper = 1
    vim.g.loaded_tarPlugin = 1
    vim.g.loaded_gzip = 1
    vim.g.loaded_zipPlugin = 1
    vim.g.loaded_2html_plugin = 1
    vim.g.loaded_shada_plugin = 1
    vim.g.loaded_spellfile_plugin = 1
    vim.g.loaded_netrw = 1
    vim.g.loaded_netrwPlugin = 1
    vim.g.loaded_tutor_mode_plugin = 1
    vim.g.loaded_remote_plugins = 1

    vim.opt.dictionary:append("/usr/share/dict/words")

end

basic.load_plugins = function()

    local execute = vim.api.nvim_command
    local fn = vim.fn
    local install_path = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'

    if fn.empty(fn.glob(install_path)) > 0 then
        fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
        execute 'packadd packer.nvim'
    end
    vim.cmd([[
	augroup packer_user_config
         autocmd!
         autocmd BufWritePost basic.lua source <afile> | PackerCompile
    augroup end
    ]])

    local packer = require('packer')

    return packer.startup(function(use)
        use 'wbthomason/packer.nvim'
        use {
            'akinsho/nvim-bufferline.lua',
             requires = 'kyazdani42/nvim-web-devicons',
             event = 'BufWinEnter',
             config = "require'laf'.setup_bufferline()"
            }

        use {'hoob3rt/lualine.nvim',
              event = 'BufWinEnter',
              config = "require'laf'.setup_statusline()"
            }
        use { 'nvim-treesitter/nvim-treesitter',
              run = ':TSUpdate',
              event = 'BufWinEnter',
              config = "require'laf'.setup_highlight()"
            }
        use { 'akinsho/toggleterm.nvim', config = "require'editor'.setup_terminal()" }
        use {'windwp/nvim-ts-autotag',  after = 'nvim-treesitter'}
        -- Colorschemes
        use 'joshdick/onedark.vim'
        use 'gruvbox-community/gruvbox'
        use 'shaunsingh/nord.nvim'
        use 'folke/tokyonight.nvim'
        use {'dracula/vim', as = 'dracula'}
        -- snippet
        use {'hrsh7th/vim-vsnip'}
        --LSP and Autocomplete
        use {'neovim/nvim-lspconfig'}
        use {'onsails/lspkind-nvim'}
        use {
            'hrsh7th/nvim-cmp',
            event = "InsertEnter *",
            config = "require'intellisense'.setup_cmp()",
            }
        use {'hrsh7th/cmp-nvim-lsp'} -- this one need to config lsp servers at start up
        use {'hrsh7th/cmp-buffer', after = "nvim-cmp"}
        use {'uga-rosa/cmp-dictionary', after = "nvim-cmp"}
        use {'hrsh7th/cmp-path',  after = "nvim-cmp"}
        use {'hrsh7th/cmp-cmdline',  after = "nvim-cmp"}
        use {'hrsh7th/cmp-vsnip',  after = "nvim-cmp"}
        --Version Control
        use {'lewis6991/gitsigns.nvim', requires = {'nvim-lua/plenary.nvim'}, event = "BufWinEnter", config = "require'editor'.setup_git()"}
        --Navigation
        use {
            'nvim-telescope/telescope.nvim',
            requires = {{'nvim-lua/popup.nvim'}, {'nvim-lua/plenary.nvim'}},
            cmd = "Telescope",
            config = "require 'navigation'.setup()",
           }
        use {'kyazdani42/nvim-tree.lua', cmd = "NvimTreeToggle", config = "require'editor'.setup_file_exploer()"}
        -- Other
        use {
            'folke/which-key.nvim',
            event = 'BufWinEnter',
            config = "require'editor'.setup_whichkey()"}
        use {'terrortylor/nvim-comment', cmd = "CommentToggle", config = "require('nvim_comment').setup()"}
        use { "justinmk/vim-sneak",
            config = function()
              vim.g["sneak#label"] = 1
            end}

        -- markdown 
        use {"ellisonleao/glow.nvim", ft = 'markdown' , config = "require'editor'.setup_markdown()"}

    end)
end

return basic
