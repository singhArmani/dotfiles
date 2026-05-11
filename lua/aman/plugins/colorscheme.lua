return {
	{
		"folke/tokyonight.nvim",
		priority = 1000, -- make sure to load this before all the other start plugins
		config = function()
			local bg = "#011628"
			local bg_dark = "#011423"
			local bg_highlight = "#143652"
			local bg_search = "#0A64AC"
			local bg_visual = "#275378"
			local fg = "#CBE0F0"
			local fg_dark = "#B4D0E9"
			local fg_gutter = "#627E97"
			local border = "#547998"

			require("tokyonight").setup({
				style = "night",
				on_colors = function(colors)
					colors.bg = bg
					colors.bg_dark = bg_dark
					colors.bg_float = bg_dark
					colors.bg_highlight = bg_highlight
					colors.bg_popup = bg_dark
					colors.bg_search = bg_search
					colors.bg_sidebar = bg_dark
					colors.bg_statusline = bg_dark
					colors.bg_visual = bg_visual
					colors.border = border
					colors.fg = fg
					colors.fg_dark = fg_dark
					colors.fg_float = fg
					colors.fg_gutter = fg_gutter
					colors.fg_sidebar = fg_dark
				end,
			})
		end,
	},
	{
		"projekt0n/github-nvim-theme",
		name = "github-theme",
		lazy = false, -- make sure we load this during startup if it is your main colorscheme
		priority = 1000, -- make sure to load this before all the other start plugins
		config = function()
			require("github-theme").setup({
				options = {
					styles = {
						comments = "italic",
						keywords = "bold",
						types = "italic,bold",
					},
				},
			})

			-- vim.cmd("colorscheme github_light_high_contrast")
		end,
	},
	{
		"rebelot/kanagawa.nvim",
		name = "kanagawa",
		priority = 1000,
		config = function()
			require("kanagawa").setup({
				theme = "wave",
			})
		end,
	},
	{
		"nyoom-engineering/oxocarbon.nvim",
		name = "oxocarbon",
		priority = 1000,
		config = function()
			vim.opt.background = "dark"
			vim.opt.termguicolors = true
		end,
	},
	{
		"rose-pine/neovim",
		name = "rose-pine",
		priority = 1000,
		config = function()
			require("rose-pine").setup({})
		end,
	},
	{
		"neanias/everforest-nvim",
		name = "everforest",
		priority = 1000,
		config = function()
			require("everforest").setup({})
		end,
	},
	{
		"bluz71/vim-moonfly-colors",
		name = "moonfly",
		priority = 1000,
	},
	{
		"AlexvZyl/nordic.nvim",
		name = "nordic",
		priority = 1000,
		config = function()
			require("nordic").setup({})
		end,
	},
	{
		"Mofiqul/dracula.nvim",
		name = "dracula",
		priority = 1000,
		config = function()
			require("dracula").setup({})
		end,
	},
	{
		"Shatur/neovim-ayu",
		name = "ayu",
		priority = 1000,
		config = function()
			require("ayu").setup({ mirage = true })
		end,
	},
	{
		"catppuccin/nvim",
		name = "catppuccin",
		priority = 1000,
		config = function()
			require("catppuccin").setup({
				flavour = "mocha", -- latte, frappe, macchiato, mocha
				-- other setup options can be added here
				integrations = {
					cmp = true,
					gitsigns = true,
					nvimtree = true,
					treesitter = true,
					mini = {
						enabled = true,
						indentscope_color = "",
					},
				},
			})
			vim.cmd([[colorscheme catppuccin]])
		end,
	},
	{
		"NLKNguyen/papercolor-theme",
		name = "paper",
	},
}
