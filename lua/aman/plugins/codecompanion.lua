return {
	"olimorris/codecompanion.nvim",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-treesitter/nvim-treesitter",
	},
	config = function()
		require("codecompanion").setup({
			strategies = {
				chat = {
					adapter = "openai",
				},
				inline = {
					adapter = "openai",
				},
			},
		})
		local map = vim.keymap.set
		-- Define key mappings for CodeCompanion using <LocalLeader>
		map(
			"n",
			"<LocalLeader>ca",
			"<cmd>CodeCompanionActions<CR>",
			{ noremap = true, silent = true, desc = "Open CodeCompanion Actions" }
		)
		map(
			"n",
			"<LocalLeader>cc",
			"<cmd>CodeCompanionChat Toggle<CR>",
			{ noremap = true, silent = true, desc = "Toggle CodeCompanion Chat" }
		)
		map(
			"v",
			"<LocalLeader>ca",
			"<cmd>CodeCompanionChat Add<CR>",
			{ noremap = true, silent = true, desc = "Add to CodeCompanion Chat" }
		)
	end,
}
