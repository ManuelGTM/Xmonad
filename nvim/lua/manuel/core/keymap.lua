vim.g.mapleader = " "

local keymap = vim.keymap -- for cocisness

-- normal keybindings

keymap.set("n", "<leader>s", ":w<cr>")
keymap.set("n", "<leader>q", ":wq<cr>")
keymap.set("n", "<C-u>", "<C-u>zz")
keymap.set("n", "<C-d>", "<C-d>zz")

-- Bash script (make the file executable)
keymap.set("n", "<leader>fx", ":!chmod +x %<CR>")

-- Web Dev
keymap.set("n", "<leader>fi", ":!firefox %<CR>")

--Compiling Programs

keymap.set("n", "<leader>ts", ":w<CR> :!tsc % <CR>")
keymap.set("n", "<leader>gcc", ":!gcc % -o %< && ./%< <CR>")

-- visual keybindings

keymap.set("v", "N", ":m '>+1<CR>gv=gv")
keymap.set("v", "K", ":m '<-2<CR>gv=gv")

-- telescope
keymap.set("n", "<leader>ff", "<cmd>Telescope find_files<cr>") -- find files within current working directory, respects .gitignore
keymap.set("n", "<leader>fs", "<cmd>Telescope live_grep<cr>") -- find string in current working directory as you type
keymap.set("n", "<leader>fc", "<cmd>Telescope grep_string<cr>") -- find string under cursor in current working directory
keymap.set("n", "<leader>fb", "<cmd>Telescope buffers<cr>") -- list open buffers in current neovim instance
keymap.set("n", "<leader>fh", "<cmd>Telescope help_tags<cr>") -- list available help tags

-- Database
keymap.set("n", "<leader>dd", ":DBUIToggle<cr>")

--Lazy Nvim
keymap.set("n", "<leader>f", ":Lazy<cr>") -- find files within current working directory, respects .gitignore

-- Oil Nvim

vim.keymap.set("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" })
