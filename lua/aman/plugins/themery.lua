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
					name = "kanagawa wave",
					colorscheme = "kanagawa-wave",
					before = [[
            vim.opt.background = "dark"
          ]],
				},
				{
					name = "rose pine (moon)",
					colorscheme = "rose-pine-moon",
					before = [[
            vim.opt.background = "dark"
            vim.opt.termguicolors = true
          ]],
				},
				{
					name = "everforest",
					colorscheme = "everforest",
					before = [[
            vim.opt.background = "dark"
            vim.opt.termguicolors = true
          ]],
				},
				{
					name = "moonfly",
					colorscheme = "moonfly",
					before = [[
            vim.opt.background = "dark"
            vim.opt.termguicolors = true
          ]],
				},
				{
					name = "nordic",
					colorscheme = "nordic",
					before = [[
            vim.opt.background = "dark"
            vim.opt.termguicolors = true
          ]],
				},
				{
					name = "dracula",
					colorscheme = "dracula",
					before = [[
            vim.opt.background = "dark"
            vim.opt.termguicolors = true
          ]],
				},
				{
					name = "ayu mirage",
					colorscheme = "ayu-mirage",
					before = [[
            vim.opt.background = "dark"
            vim.opt.termguicolors = true
          ]],
				},
				{
					name = "oxocarbon",
					colorscheme = "oxocarbon",
					before = [[
            vim.opt.background = "dark"
            vim.opt.termguicolors = true
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
