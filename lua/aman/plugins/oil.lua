return {
	"stevearc/oil.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	config = function()
		require("oil").setup({
			default_file_explorer = true,
			columns = { "icon" },
			view_options = {
				show_hidden = false,
			},
			float = {
				padding = 2,
				border = "rounded",
			},
		})

		local keymap = vim.keymap
		keymap.set("n", "<leader>u", "<cmd>Oil<CR>", { desc = "Open file explorer" })
		keymap.set("n", "<leader>v", "<cmd>Oil<CR>", { desc = "Open file explorer" })
		keymap.set("n", "<leader>ef", function()
			require("oil").open(vim.fn.expand("%:p:h"))
		end, { desc = "Open file explorer at current file" })
	end,
}
