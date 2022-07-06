local telescope = require('telescope')

telescope.setup {
  defaults = { 
    file_ignore_patterns = {"node_modules"}, 
    layout_strategy = "vertical",
    layout_config = {
      height = 0.95,
      prompt_position = 'top',
    },
  },
  pickers = {
    find_files = {
      hidden = true,
    },
  },
}

-- To get fzf loaded and working with telescope,
-- you need to call load_extension, somewhere after
-- the setup function.
telescope.load_extension('fzf')
