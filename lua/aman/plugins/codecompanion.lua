return {
	"olimorris/codecompanion.nvim",
	version = "v17.33.0",
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
		map("x", "<LocalLeader>ci", function()
			-- Leave visual mode so the '< / '> marks are committed, then capture
			-- the selected line range *before* the async prompt. vim.ui.input
			-- clears the selection, so referencing '<,'> in on_confirm raised
			-- E20: Mark not set.
			vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Esc>", true, false, true), "x", false)
			local start_line = vim.api.nvim_buf_get_mark(0, "<")[1]
			local end_line = vim.api.nvim_buf_get_mark(0, ">")[1]
			vim.ui.input({ prompt = "Instruction for CodeCompanion: " }, function(input)
				if input and input ~= "" then
					vim.cmd(string.format("%d,%dCodeCompanion %s", start_line, end_line, input))
				end
			end)
		end, { noremap = true, silent = true, desc = "CodeCompanion: Inline Edit with Prompt" })
	end,
}
