-- must be set before calling require
vim.g.nvim_tree_indent_markers = 1 -- this option shows indent markers when folders are open

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
    }
}

vim.api.nvim_set_keymap('n', '<space>t', ':NvimTreeToggle<CR>', {noremap = true, silent = true})
