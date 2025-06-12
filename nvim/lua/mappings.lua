require "nvchad.mappings"

-- add yours here

-- Map jj to escape in insert mode
vim.api.nvim_set_keymap('i', 'jj', '<Esc>', { noremap = true, silent = true, desc = "Exit Insert mode with jj" })

-- Optionally, you can also map it in terminal mode
vim.api.nvim_set_keymap('t', 'jj', '<Esc>', { noremap = true, silent = true, desc = "Exit Terminal mode with jj" })


local map = vim.keymap.set

map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")

-- map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>")
