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
		local opts = { noremap = true, silent = true }

		-- 🧠 CodeCompanion Actions UI
		map(
			"n",
			"<LocalLeader>ca",
			"<cmd>CodeCompanionActions<CR>",
			vim.tbl_extend("force", opts, { desc = "CodeCompanion: Actions Palette" })
		)

		-- 💬 Toggle Chat UI
		map(
			"n",
			"<LocalLeader>cc",
			"<cmd>CodeCompanionChat Toggle<CR>",
			vim.tbl_extend("force", opts, { desc = "CodeCompanion: Toggle Chat UI" })
		)

		-- 🧩 Add selection to chat context (Visual Mode)
		map(
			"v",
			"<LocalLeader>cc",
			"<cmd>CodeCompanionChat Add<CR>",
			vim.tbl_extend("force", opts, { desc = "CodeCompanion: Add to Chat Context" })
		)

		-- ⚡ Inline edit (Visual Mode)
		map("v", "<LocalLeader>ci", function()
			vim.ui.input({ prompt = "Instruction for CodeCompanion: " }, function(input)
				if input then
					vim.cmd("'<,'>CodeCompanion " .. input)
				end
			end)
		end, { noremap = true, silent = true, desc = "CodeCompanion: Inline Edit with Prompt" })
	end,
}
