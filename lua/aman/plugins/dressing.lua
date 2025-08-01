return {
	"stevearc/dressing.nvim",
	event = "VeryLazy",
	opts = {
		input = {
			enabled = true,
			prefer_width = 60, -- 👈 increase width here
			win_options = {
				winblend = 0,
			},
		},
	},
}
