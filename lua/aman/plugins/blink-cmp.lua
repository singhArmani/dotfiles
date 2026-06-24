return {
	"saghen/blink.cmp",
	version = "*",
	dependencies = {
		{
			"L3MON4D3/LuaSnip",
			version = "v2.*",
			build = "make install_jsregexp",
			config = function()
				local luasnip = require("luasnip")
				require("luasnip.loaders.from_vscode").lazy_load({ paths = "~/.config/nvim/snippets" })
				require("luasnip.loaders.from_lua").load({ paths = "~/.config/nvim/snippets" })
				luasnip.filetype_extend("typescriptreact", { "typescript", "javascript" })
			end,
		},
		"rafamadriz/friendly-snippets",
		"kristijanhusak/vim-dadbod-completion",
	},
	opts = {
		keymap = {
			preset = "none",
			["<C-e>"] = { "hide", "fallback" },
			["<CR>"] = { "accept", "fallback" },
			["<Tab>"] = { "select_next", "snippet_forward", "fallback" },
			["<C-b>"] = { "scroll_documentation_up", "fallback" },
			["<C-f>"] = { "scroll_documentation_down", "fallback" },
		},
		snippets = { preset = "luasnip" },
		sources = {
			default = { "lsp", "path", "snippets", "buffer", "dadbod", "codecompanion" },
			providers = {
				dadbod = { name = "Dadbod", module = "vim_dadbod_completion.blink" },
				codecompanion = { name = "CodeCompanion", module = "codecompanion.providers.completion.blink" },
			},
		},
		appearance = {
			nerd_font_variant = "mono",
		},
		completion = {
			accept = { auto_brackets = { enabled = true } },
			documentation = { auto_show = true, auto_show_delay_ms = 500 },
			menu = { border = "rounded" },
		},
		signature = { enabled = true },
	},
}
