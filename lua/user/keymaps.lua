local opts = { noremap = true, silent = true }

-- Shorten function name
local keymap = vim.api.nvim_set_keymap

--Remap space as leader key
keymap("", "<Space>", "<Nop>", opts)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Modes
--   normal_mode = "n",
--   insert_mode = "i",
--   visual_mode = "v",
--   visual_block_mode = "x",
--   term_mode = "t",
--   command_mode = "c",


-- Normal --
-- Navigate buffers
keymap("n", "<S-l>", ":bnext<CR>", opts)
keymap("n", "<S-h>", ":bprevious<CR>", opts)

-- Telescope
-- <CR> -> carriage return = enter
keymap("n", "<C-p>", "<CMD>Telescope find_files<CR>", opts)
keymap("n", "<leader>fg", "<CMD>Telescope live_grep<CR>", opts)

-- NvimTree
keymap("n", "<leader>t", "<CMD>:NvimTreeToggle<CR>", opts)

-- Formatting
keymap("n", "<leader>f", "<CMD>:Format<CR>", opts)

-- Visual --
-- Stay in indent mode
keymap("v", "<", "<gv", opts)
keymap("v", ">", ">gv", opts)

-- 選取後貼上不會變成複製到被改掉的東西
keymap("v", "p", '"_dP', opts)

-- Visual Block --
-- Move text up and down
keymap("x", "J", ":move '>+1<CR>gv-gv", opts)
keymap("x", "K", ":move '<-2<CR>gv-gv", opts)
