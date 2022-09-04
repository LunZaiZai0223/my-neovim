local status_ok, telescope = pcall(require, "telescope")
if not status_ok then
  return
end

local actions = require "telescope.actions"

telescope.setup {
  defaults = {
    file_ignore_patterns = { "node_modules", ".git/" },
    layout_strategy = "vertical",
    selection_caret = " ",
    path_display = { "smart" },
    layout_config = {
      height = 0.95,
      prompt_position = 'top',
    },
    mappings = {
      i = {
        -- map actions.which_key to <C-h> (default: <C-/>)
        -- actions.which_key shows the mappings for your picker,
        -- e.g. git_{create, delete, ...}_branch for the git_branches picker
        ["gg"] = actions.move_to_top,
        ["G"] = actions.move_to_bottom,
        ["<C-n>"] = actions.cycle_history_next,
        ["<C-p>"] = actions.cycle_history_prev,
      }
    }
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
