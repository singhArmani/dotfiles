return {
	"ibhagwan/fzf-lua",
	event = "VeryLazy",
	dependencies = {
		"nvim-tree/nvim-web-devicons",
		"folke/todo-comments.nvim",
	},
	config = function()
		local fzf = require("fzf-lua")

		fzf.setup({
			winopts = {
				preview = {
					layout = "horizontal",
					horizontal = "right:50%",
				},
			},
			keymap = {
				fzf = {
					["ctrl-q"] = "select-all+accept",
				},
			},
		})

		vim.schedule(function()
			fzf.register_ui_select()
		end)

		local keymap = vim.keymap

		keymap.set("n", ";", fzf.files, { desc = "Fuzzy find files in cwd" })
		-- find files including hidden and gitignored ones (.git excluded)
		keymap.set("n", "<leader>fi", function()
			fzf.files({ fd_opts = "--color=never --type f --hidden --no-ignore --exclude .git" })
		end, { desc = "Fuzzy find files (incl. gitignored)" })
		keymap.set("n", "<leader>fr", fzf.oldfiles, { desc = "Fuzzy find recent files" })
		keymap.set("n", "<leader>fs", fzf.live_grep, { desc = "Find string in cwd" })
		keymap.set("n", "<leader>fc", fzf.grep_cword, { desc = "Find string under cursor in cwd" })
		keymap.set("n", "<leader>ft", "<cmd>TodoFzfLua<cr>", { desc = "Find todos" })
	end,
}
