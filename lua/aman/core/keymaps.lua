-- set leader key to space
vim.g.mapleader = " "

local keymap = vim.keymap -- for conciseness

---------------------
-- General Keymaps -------------------

-- clear search highlights
keymap.set("n", "<leader>nh", ":nohl<CR>", { desc = "Clear search highlights" })

--window management
keymap.set("n", "<leader>sv", "<C-w>v", { desc = "Split window vertically" }) -- split window vertically
keymap.set("n", "<leader>sh", "<C-w>s", { desc = "Split window horizontally" }) -- split window horizontally
keymap.set("n", "<leader>se", "<C-w>=", { desc = "Make splits equal size" }) -- make split windows equal width & height
keymap.set("n", "<leader>sx", "<cmd>close<CR>", { desc = "Close current split" }) -- close current split window

keymap.set("n", "<leader>to", "<cmd>tabnew<CR>", { desc = "Open new tab" }) -- open new tab
keymap.set("n", "<leader>tx", "<cmd>tabclose<CR>", { desc = "Close current tab" }) -- close current tab
keymap.set("n", "<leader>tn", "<cmd>tabn<CR>", { desc = "Go to next tab" }) --  go to next tab
keymap.set("n", "<leader>tp", "<cmd>tabp<CR>", { desc = "Go to previous tab" }) --  go to previous tab
keymap.set("n", "<leader>tf", "<cmd>tabnew %<CR>", { desc = "Open current buffer in new tab" }) --  move current buffer to new tab
keymap.set("n", "<leader>q", "<cmd>quit<CR>", { desc = "Close current buffer" }) --  move current buffer to new tab

-- Replace with dot command
keymap.set("n", "c*", "*Ncgn", { noremap = true, desc = "Replace with dot command *" })
keymap.set("n", "c#", "#NcgN", { noremap = true, desc = "Replace with dot command #" })

-- Reselect pasted text
keymap.set("n", "gp", "`[v`]", { noremap = true })

-- Navigation split
keymap.set("n", "<leader>j", "<C-w><C-j>", { desc = "Mapping leader key for navigation split windows" }) -- Mapping leader key for navigation split windows
keymap.set("n", "<leader>k", "<C-w><C-k>", { desc = "Mapping leader key for navigation split windows" }) -- Mapping leader key for navigation split windows
keymap.set("n", "<leader>l", "<C-w><C-l>", { desc = "Mapping leader key for navigation split windows" }) -- Mapping leader key for navigation split windows
keymap.set("n", "<leader>h", "<C-w><C-h>", { desc = "Mapping leader key for navigation split windows" }) -- Mapping leader key for navigation split windows

keymap.set("n", "<S-n>", ":bp<CR>", { desc = "Move to the previous buffer with 'Shift+n'" }) -- Move to the previous buffer with "Shift+n"
keymap.set("n", "<S-m>", ":bn<CR>", { desc = "Move to the next buffer with 'Shift+m'" }) -- Move to the next buffer with "Shift+m"

keymap.set("n", "<Leader>w", ":update<CR>", { noremap = true, desc = "Save current buffer content to file" })

keymap.set("v", "J", "<cmd>m '>+1<cr>gv=gv", { desc = "Move visual selection down" })
keymap.set("v", "K", "<cmd>m '<-2<cr>gv=gv", { desc = "Move visual selection up" })

keymap.set("n", "cp", "yap<S-}>p", { desc = "Clone paragraph with cp" })
keymap.set("n", "<leader>p", '"0p', { desc = "Paste yanked content from register 0" })
keymap.set("n", "<Leader>d", '"_d', { desc = "Use black hole register for deleting" })
keymap.set("n", "<leader>bb", ":Bdelete<CR>", { desc = "Delete buffers without closing windows" })
