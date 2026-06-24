return {
	"stevearc/oil.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	config = function()
		require("oil").setup({
			columns = {},
			view_options = {
				show_hidden = true,
			},
			keymaps = {
				["<C-h>"] = false,
				["<C-l>"] = false,
				["<C-p>"] = false,
				["_"] = false,
			},
		})

		vim.keymap.set("n", "<leader>v", "<cmd>Oil<cr>", { silent = true, desc = "Open parent directory" })
	end,
}
