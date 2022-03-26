-- must be set before calling require
vim.g.nvim_tree_indent_markers = 1 -- this option shows indent markers when folders are open

local tree_cb = require'nvim-tree.config'.nvim_tree_callback

require('nvim-tree').setup {
  auto_close = true,
  update_cwd = true,
  update_focused_file = {
    enable = true,
    update_cwd = true,
    ignore_list = {},
  },
  view = {
    auto_resize = true,
    width = 25,
    mappings = {
      custom_only = false,
      list = {
        -- user mappings go here
      { key = "v", cb = tree_cb("vsplit") },
      },
    },
  },
  diagnostics = {
    enable = true,
    show_on_dirs = true,
    icons = {
      hint = "",
      info = "",
      warning = "",
      error = "",
    },
  },
  git = {
    enable = true,
    ignore = true,
    timeout = 500,
  }
}

vim.api.nvim_set_keymap('n', '<space>t', ':NvimTreeToggle<CR>', {noremap = true, silent = true})
