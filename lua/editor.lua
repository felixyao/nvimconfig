--this file configures the edtor functions
--Keybanding
--editor functions such as file exploer. git terminal

local editor = {}

editor.setup_whichkey = function()
    local mappings = {
        t = {':ToggleTerm<CR>', 'Terminal'},
        p = {
            name = 'Packer',
            r = {':PackerClean<CR>', 'Remove Unused Plugins'},
            c = {':PackerCompile profile=true<CR>', 'ReCompile Plugins'},
            i = {':PackerInstall<CR>', 'Install Plugins'},
            S = {':PackerSync<CR>', 'Sync Plugins'},
            s = {':PackerStatus<CR>', 'Plugins status'},
            u = {':PackerUpdate<CR>', 'Update Plugins'},
        },
        e = {':NvimTreeToggle<CR>', 'File Exploer'},
        f = {'<cmd>Telescope find_files<CR>', 'Find file'},
        s = {'<cmd>Telescope grep_string<CR>', 'Seach text under cusor'},
        g = {
            name = 'goto ',
            d = {'<cmd>Telescope lsp_definitions<CR>', '[LSP] goto definition'},
            t = {'<cmd>Telescope lsp_type_definitions<CR>', '[LSP] goto type definition'},
            i = {'<cmd>Telescope lsp_implementations<CR>', '[LSP] goto implementation'},
            j = {'<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', '[LSP] goto next error'},
            k = {'<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', '[LSP] goto previous error'},
            p = {'<cmd>Telescope jumplist<CR>', 'goto previous visted places'},
        },
        S = {
            name = 'search',
            f = {'<cmd>Telescope git_files<CR>', 'Find git files'},
            b = {'<cmd>Telescope buffers<CR>', 'find buffer'},
            s = {'<cmd>Telescope live_grep<CR>', 'search text in files'},
            r = {'<cmd>Telescope lsp_references<CR>', '[LSP] find references'},
            o = {'<cmd>Telescope oldfiles<CR>', 'Recent Files'},
            e = {'<cmd>Telescope lsp_workspace_diagnostics<CR>', '[LSP] find errors'},
        },
        h = {
            name = 'help',
            c = {'<cmd>Telescope commands<CR>', 'vim commands'},
            k = {'<cmd>Telescope keymaps<CR>', 'vim keymaps'},
            f = {'<cmd>Telescope filetypes<CR>', 'vim filetypes'},
            o = {'<cmd>Telescope colorscheme<CR>', 'vim colorscheme'},
            h = {'<cmd>Telescope help_tags<CR>', 'vim help'},
            l = {'<cmd>LspInfo<CR>', '[LSP] print lsp info'},
        },
        v = {
            name = "version control",
            j = { "<cmd>lua require 'gitsigns'.next_hunk()<cr>", "Next Hunk" },
            k = { "<cmd>lua require 'gitsigns'.prev_hunk()<cr>", "Prev Hunk" },
            b = { "<cmd>lua require 'gitsigns'.blame_line()<cr>", "Blame" },
            p = { "<cmd>lua require 'gitsigns'.preview_hunk()<cr>", "Preview Hunk" },
            r = { "<cmd>lua require 'gitsigns'.reset_hunk()<cr>", "Reset Hunk" },
            R = { "<cmd>lua require 'gitsigns'.reset_buffer()<cr>", "Reset Buffer" },
            s = { "<cmd>lua require 'gitsigns'.stage_hunk()<cr>", "Stage Hunk" },
            u = { "<cmd>lua require 'gitsigns'.undo_stage_hunk()<cr>", "Undo Stage Hunk", },
            o = { "<cmd>Telescope git_status<cr>", "Open changed file" },
            c = { "<cmd>Telescope git_commits<cr>", "Checkout commit" },
            C = {
                    "<cmd>Telescope git_bcommits<cr>",
                    "Checkout commit(for current file)",
            },
            d = {
                "<cmd>Gitsigns diffthis HEAD<cr>",
                "Git Diff",
            },
        },
    }
    local opts = { prefix = '<leader>'}
    local wk = require('which-key')
    wk.register(mappings, opts)
end

editor.setup_keymapping= function()
    vim.g.mapleader = " ",
    vim.api.nvim_set_keymap('i', 'jk', '<ESC>', {noremap = true})
    vim.api.nvim_set_keymap('i', 'kj', '<ESC>', {noremap = true})
    vim.api.nvim_set_keymap('n', '<C-Up>', ':resize -2<CR>', {noremap = true, silent = true})
    vim.api.nvim_set_keymap('n', '<C-Down>', ':resize +2<CR>', {noremap = true, silent = true})
    vim.api.nvim_set_keymap('n', '<C-Left>', ':vertical resize -2<CR>', {noremap = true, silent = true})
    vim.api.nvim_set_keymap('n', '<C-Right>', ':vertical resize +2<CR>', {noremap = true, silent = true})

    vim.api.nvim_set_keymap('n', '<C-h>', '<C-w>h', {noremap = true, silent = false})
    vim.api.nvim_set_keymap('n', '<C-j>', '<C-w>j', {noremap = true, silent = false})
    vim.api.nvim_set_keymap('n', '<C-k>', '<C-w>k', {noremap = true, silent = false})
    vim.api.nvim_set_keymap('n', '<C-l>', '<C-w>l', {noremap = true, silent = false})

    vim.api.nvim_set_keymap('t', '<C-h>', '<C-\\><C-N><C-w>h', {noremap = true, silent = false})
    vim.api.nvim_set_keymap('t', '<C-j>', '<C-\\><C-N><C-w>j', {noremap = true, silent = false})
    vim.api.nvim_set_keymap('t', '<C-k>', '<C-\\><C-N><C-w>k', {noremap = true, silent = false})
    vim.api.nvim_set_keymap('t', '<C-l>', '<C-\\><C-N><C-w>l', {noremap = true, silent = false})

    vim.api.nvim_set_keymap('n', '<S-l>', ':BufferLineCycleNext<CR>', {noremap = true, silent = true})
    vim.api.nvim_set_keymap('n', '<S-h>', ':BufferLineCyclePrev<CR>', {noremap = true, silent = true})
    vim.api.nvim_set_keymap('n', '<A-S-l>', ':BufferLineMoveNext<CR>', {noremap = true, silent = true})
    vim.api.nvim_set_keymap('n', '<A-S-h>', ':BufferLineMovePrev<CR>', {noremap = true, silent = true})

    vim.api.nvim_set_keymap('v', '<', '<gv', {noremap = true, silent = false})
    vim.api.nvim_set_keymap('v', '>', '>gv', {noremap = true, silent = false})

    vim.api.nvim_set_keymap('x', 'A-k', ':move \'<-2<CR>gv-gv', {noremap = true, silent = true})
    vim.api.nvim_set_keymap('x', 'A-j', ':move \'>+1<CR>gv-gv', {noremap = true, silent = true})

    vim.api.nvim_set_keymap('v', '<leader>/', ':CommentToggle<cr>', {noremap = true, silent = true})

    vim.cmd('inoremap <expr> <c-j> (\"\\<C-n>\")')
    vim.cmd('inoremap <expr> <c-k> (\"\\<C-p>\")')
end

editor.setup= function()
    vim.g.nvim_tree_gitignore = 1
    vim.g.nvim_tree_highlight_opened_files = 1
    vim.g.nvim_tree_indent_markers = 1
    vim.g.nvim_tree_icons = {
        default = "",
        symlink = "",
        git = {
            unstaged = "",
            staged = "S",
            unmerged = "",
            renamed = "➜",
            deleted = "",
            untracked = "U",
            ignored = "◌",
        },
        folder = {
            default = "",
            open = "",
            empty = "",
            empty_open = "",
            symlink = "",
        },
    }

end

editor.setup_terminal = function()
	require"toggleterm".setup {
        size = 20,
        open_mapping = [[<c-a-t>]],
        hide_numbers=true,
        shade_filetypes = {},
        shade_terminals = true,
        shading_factor = '1',
        start_in_insert = true,
        persist_size = true,
        direction = 'horizontal'
    }
end

editor.setup_file_exploer= function()
    require'nvim-tree'.setup {
        disable_netrw = true,
        hijack_netrw = true,
        open_on_setup = true,
        ignore_ft_on_setup = {'dashboard'},
        auto_close = true,
        open_on_tab = false,
        hijack_cursor = true,
        update_cwd = true,
        update_focused_file = {enable = true, update_cwd = true, ignore_list = {}},
        system_open = {
            -- the command to run this, leaving nil should work in most cases
             cmd = nil,
            --the command arguments as a list
            args = {}
        },
        view = {width = 25, side = 'left', auto_resize = true, mappings = {custom_only = false, list = {}}},
        filters = {
            dotfiles = true,
            custom = {'node_modules'}
        },
    }
end

editor.setup_git = function()
    require('gitsigns').setup {
    signs = {
        add = {hl = 'GitSignsAdd', text = '▎', numhl = 'GitSignsAddNr', linehl = 'GitSignsAddLn'},
        change = {hl = 'GitSignsChange', text = '▎', numhl = 'GitSignsChangeNr', linehl = 'GitSignsChangeLn'},
        delete = {hl = 'GitSignsDelete', text = '契', numhl = 'GitSignsDeleteNr', linehl = 'GitSignsDeleteLn'},
        topdelete = {hl = 'GitSignsDelete', text = '契', numhl = 'GitSignsDeleteNr', linehl = 'GitSignsDeleteLn'},
        changedelete = {hl = 'GitSignsChange', text = '▎', numhl = 'GitSignsChangeNr', linehl = 'GitSignsChangeLn'}
    },
    numhl = false,
    linehl = false,
    keymaps = {noremap = true, buffer = true},
    watch_gitdir = {interval = 1000},
    sign_priority = 6,
    update_debounce = 200,
    status_formatter = nil
    }
end
return editor
