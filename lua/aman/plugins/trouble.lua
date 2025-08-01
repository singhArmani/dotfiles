return {
	"folke/trouble.nvim",
	version = "v3.7.1",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	opts = {
		-- Disable global auto behaviors
		-- modes = {
		-- 	diagnostics = {
		-- 		auto_open = true, -- Auto open for diagnostics mode
		-- 		auto_preview = true, -- Auto preview when hover
		-- 		filter = {
		-- 			severity = {
		-- 				min = vim.diagnostic.severity.WARN, -- Show WARN and ERROR only
		-- 			},
		-- 		},
		-- 	},
		-- },
		-- win = {
		-- 	position = "bottom",
		-- 	size = { height = 0.1 },
		-- },
	},
	keys = {
		{
			"<leader>xx",
			"<cmd>Trouble diagnostics toggle<cr>",
			desc = "Diagnostics (Trouble)",
		},
		{
			"<leader>xX",
			"<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
			desc = "Buffer Diagnostics (Trouble)",
		},
		{
			"<leader>cs",
			"<cmd>Trouble symbols toggle focus=false<cr>",
			desc = "Symbols (Trouble)",
		},
		{
			"<leader>cl",
			"<cmd>Trouble lsp toggle focus=false win.position=right<cr>",
			desc = "LSP Definitions / references / ... (Trouble)",
		},
	},
}
