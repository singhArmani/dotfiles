-- Review-oriented git UI: file-tree + side-by-side diff for a whole branch
-- (:DiffviewOpen master...HEAD), file history, and 3-way merge-conflict view.
-- Complements fugitive's <leader>gd (:Gdiff, fast single-file diff).
return {
	"sindrets/diffview.nvim",
	cmd = { "DiffviewOpen", "DiffviewFileHistory", "DiffviewClose", "DiffviewToggleFiles" },
	opts = {},
	keys = {
		{
			"<leader>gD",
			function()
				-- toggle: close if a diffview tab is already open, else open the changeset
				if next(require("diffview.lib").views) == nil then
					vim.cmd("DiffviewOpen")
				else
					vim.cmd("DiffviewClose")
				end
			end,
			desc = "Diffview: toggle changeset (all files)",
		},
		{
			"<leader>gh",
			"<cmd>DiffviewFileHistory %<cr>",
			desc = "Diffview: current file history",
		},
	},
}
