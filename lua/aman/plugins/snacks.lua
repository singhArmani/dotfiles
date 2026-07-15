return {
	"folke/snacks.nvim",
	priority = 1000,
	lazy = false,
	opts = {
		explorer = { enabled = true },
		picker = {
			sources = {
				explorer = {
					layout = { preset = "sidebar", preview = false, layout = { position = "right" } },
					hidden = true, -- show dotfiles
					ignored = false, -- hide gitignored files like node_modules (toggle with 'i')
					git_status = true,
					follow_file = true, -- reveal current buffer in tree
					auto_close = true, -- close explorer after opening a file
				},
			},
		},
	},
	keys = {
		{ "<leader>v", function() Snacks.explorer() end, desc = "File Explorer (tree)" },
	},
}
