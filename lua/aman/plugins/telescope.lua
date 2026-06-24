return {
	"ibhagwan/fzf-lua",
	dependencies = {
		"nvim-tree/nvim-web-devicons",
		"folke/todo-comments.nvim",
	},
	config = function()
		local fzf = require("fzf-lua")

		fzf.setup({
			winopts = {
				preview = {
					layout = "vertical",
					vertical = "down:50%",
				},
			},
			keymap = {
				fzf = {
					["ctrl-q"] = "select-all+accept",
				},
			},
		})

		local keymap = vim.keymap

		keymap.set("n", ";", fzf.files, { desc = "Fuzzy find files in cwd" })
		keymap.set("n", "<leader>fr", fzf.oldfiles, { desc = "Fuzzy find recent files" })
		keymap.set("n", "<leader>fs", fzf.live_grep, { desc = "Find string in cwd" })
		keymap.set("n", "<leader>fc", fzf.grep_cword, { desc = "Find string under cursor in cwd" })
		keymap.set("n", "<leader>ft", "<cmd>TodoFzfLua<cr>", { desc = "Find todos" })
	end,
}
