local status_ok, telescope = pcall(require, "telescope")
if not status_ok then
  return
end

-- local telescope = require('telescope')

telescope.setup {
  defaults = { 
    file_ignore_patterns = {"node_modules", ".git/" }, 
    layout_strategy = "vertical",
    selection_caret = " ",
    path_display = { "smart" },
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
  extensions = {
    media_files = {
      -- filetypes whitelist
      -- defaults to {"png", "jpg", "mp4", "webm", "pdf"}
      filetypes = { "png", "webp", "jpg", "jpeg" },
      find_cmd = "rg", -- find command (defaults to `fd`)
    },
  },
}

-- To get fzf loaded and working with telescope,
-- you need to call load_extension, somewhere after
-- the setup function.
telescope.load_extension('fzf')
