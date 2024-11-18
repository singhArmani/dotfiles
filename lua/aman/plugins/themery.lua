return {
	"zaldih/themery.nvim",
	lazy = false,
	config = function()
		require("themery").setup({
			themes = {
				{
					name = "catppuccin dark",
					colorscheme = "catppuccin-mocha",
					before = [[
            vim.opt.background = "dark"
          ]],
				},
				{
					name = "github light",
					colorscheme = "github_light_high_contrast",
					before = [[
            vim.opt.background = "light"
          ]],
				},
				{
					name = "paper light",
					colorscheme = "PaperColor",
					before = [[
            vim.opt.background = "light"
            vim.opt.termguicolors = true
          ]],
				},
			},
			livePreview = true, -- Apply theme while picking. Default to true.
		})
		vim.api.nvim_set_keymap(
			"n",
			"<leader>th",
			":Themery<CR>",
			{ noremap = true, silent = true, desc = "Pick theme" }
		)
	end,
}
