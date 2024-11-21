return {
	{
		"MagicDuck/grug-far.nvim",
		config = function()
			-- Setup keybindings after plugin is loaded
			local map = vim.api.nvim_set_keymap
			local opts = { noremap = true, silent = true }
			require("grug-far").setup({})

			-- Keybinding: Launch with the current word under the cursor as the search string
			map(
				"n",
				"<LocalLeader>w",
				"<cmd>lua require('grug-far').open({ prefills = { search = vim.fn.expand('<cword>') } })<CR>",
				opts
			)

			-- Keybinding: Launch as a transient buffer (unlisted, deletes itself after use)
			map("n", "<LocalLeader>t", "<cmd>lua require('grug-far').open({ transient = true })<CR>", opts)

			-- Keybinding: Limit search/replace to the current file
			map(
				"n",
				"<LocalLeader>f",
				"<cmd>lua require('grug-far').open({ prefills = { paths = vim.fn.expand('%') } })<CR>",
				opts
			)

			-- Keybinding: Launch with the current visual selection, searching only in the current file
			map(
				"v",
				"<LocalLeader>v",
				"<cmd>lua require('grug-far').with_visual_selection({ prefills = { paths = vim.fn.expand('%') } })<CR>",
				opts
			)

			-- Keybinding: Toggle visibility of a particular instance and set title to "Find and Replace"
			map(
				"n",
				"<LocalLeader>fr",
				"<cmd>lua require('grug-far').toggle_instance({ instanceName = 'far', staticTitle = 'Find and Replace' })<CR>",
				opts
			)
		end,
	},
}
