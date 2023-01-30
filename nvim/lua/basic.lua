-- gruvbox
vim.opt.termguicolors = true
vim.o.background = 'dark'
vim.g.gruvbox_material_transparent_background = 1
vim.cmd([[colorscheme gruvbox-material]])

-- lualine
require('lualine').setup {
  options = {
    gloabl_status = true,
    component_separators = '',
    section_separators = '',
    disabled_filetypes = {
      'packer',
      'NvimTree',
    },
  },
  sections = {
    lualine_b = { 'branch', 'diff' },
    lualine_c = {
      { 'filetype', icon_only = true, padding = { left = 1 } },
      'filename',
    },
    lualine_x = {},
    lualine_y = { 'encoding', 'diagnostics' },
    lualine_z = { 'progress' },
  },
}

-- toggleterm
require("toggleterm").setup {
  open_mapping = [[<c-\>]],
  direction = 'float',
  insert_mappings = true,
  terminal_mappings = true,
}

-- nvim-tree
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
require("nvim-tree").setup {
  view = {
    side = 'right',
    hide_root_folder = true,
    mappings = {
      list = {
        { key = "l", action = "edit" },
        { key = "h", action = "close_node" },
        { key = "/", action = "live_filter" },
        { key = "<esc>", action = "clear_live_filter" },
      }
    }
  },
  renderer = {
    highlight_opened_files = 'name',
  },
  filters = {
    custom = {
      '.git',
      '.cache',
      'node_modules',
    },
  },
}

-- nvim-colorizer
require('colorizer').setup()

-- telescope
local action = require('telescope.actions')
require('telescope').setup {
  defaults = {
    mappings = {
      n = {
        ['d'] = action.delete_buffer,
        ['s'] = action.select_horizontal,
        ['v'] = action.select_vertical,
      }
    }
  }
}
