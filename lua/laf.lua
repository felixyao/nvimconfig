-- this file configures the editors look and feel
local laf = {}
laf.setup_statusline = function()
    require('lualine').setup {
        options = {
            theme = 'onedark',
        },
        section_separators = { left = '', right = ''},
        component_separators = { left = '', right = ''},
        sections = {lualine_x = {"os.date('%c')", 'status'}},
        extensions = {'nvim-tree', 'toggleterm'},
    }
end

laf.setup_bufferline = function()
    require"bufferline".setup {
        options = {
            offsets = {
              {filetype = "NvimTree", text = "File Explorer", highlight = "Directory", text_align = "center"}
            },
	     close_command = "bdelete! %d",       -- can be a string | function, see "Mouse actions"
	     right_mouse_command = "bdelete! %d", -- can be a string | function, see "Mouse actions"
		 left_mouse_command = "buffer %d",    -- can be a string | function, see "Mouse actions"
		 middle_mouse_command = nil,          -- can be a string | function, see "Mouse actions"
	     indicator_icon = '▎',
	     buffer_close_icon = '',
		 modified_icon = '●',
		 close_icon = '', left_trunc_marker = '',
		 right_trunc_marker = '',
         show_buffer_icons = true, -- disable filetype icons for buffers
         show_buffer_close_icons = true,
         show_close_icon = true,
         show_tab_indicators = true,
         },
        }
end

laf.setup_highlight = function()
    require('nvim-treesitter.configs').setup {
        ensure_installed = {'c', 'cpp', 'bash', 'lua', 'python'},
        indent = {enable = true},
        highlight = {enable = true},
        autotag = {enable = true},
        keymaps = {
            init_selection = 'gnn',
            node_incremental = 'grn',
            scope_incremental = 'grc',
            node_decremental = 'grm',
        }
    }
end
laf.setup = function()
    vim.o.termguicolors = true
    vim.cmd('colorscheme onedark')
end
return laf
