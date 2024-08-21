return {
	{
		"tpope/vim-fugitive",
		event = "BufEnter",
		config = function()
			-- Keymaps
			vim.keymap.set("n", "<leader>gd", ":Gdiff<CR>", { noremap = true, silent = true })
			vim.keymap.set("n", "<leader>gr", ":Gread<CR>", { noremap = true, silent = true })
		end,
	},
	{
		-- Adds git related signs to the gutter, as well as utilities for managing changes
		"lewis6991/gitsigns.nvim",
		enabled = true,
		event = "VeryLazy",
		opts = {
			-- See `:help gitsigns.txt`
			signs = {
				add = { text = "+" },
				change = { text = "~" },
				delete = { text = "_" },
				topdelete = { text = "‾" },
				changedelete = { text = "~" },
			},
			current_line_blame = true,
			on_attach = function(bufnr)
				local gitsigns = require("gitsigns")
				vim.keymap.set("n", "]n", gitsigns.next_hunk, { buffer = bufnr, desc = "Go to Next Hunk" })
				vim.keymap.set("n", "[n", gitsigns.prev_hunk, { buffer = bufnr, desc = "Go to Previous Hunk" })
				vim.keymap.set(
					"n",
					"<leader>gp",
					gitsigns.preview_hunk,
					{ buffer = bufnr, desc = "[G]it [P]review Hunk" }
				)
			end,
		},
	},
}
