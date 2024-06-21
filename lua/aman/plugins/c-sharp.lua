return {
	"iabdelkareem/csharp.nvim",
	dependencies = {
		"williamboman/mason.nvim", -- Required, automatically installs omnisharp
		"mfussenegger/nvim-dap",
		"Tastyep/structlog.nvim", -- Optional, but highly recommended for debugging
		{ "Hoffs/omnisharp-extended-lsp.nvim", lazy = true },
	},
	opts = {
		lsp = {
			on_attach = function(_, bufnr)
				local omnisharp = require("omnisharp_extended")
				vim.keymap.set("n", "gd", function()
					omnisharp.telescope_lsp_definitions()
				end, { buffer = bufnr, noremap = true, silent = true, desc = "LSP: [G]oto [D]efinition" })
				vim.keymap.set("n", "gI", function()
					omnisharp.telescope_lsp_implementation()
				end, { buffer = bufnr, noremap = true, silent = true, desc = "LSP: [G]oto [I]mplementation" })
				vim.keymap.set("n", "gr", function()
					omnisharp.telescope_lsp_references()
				end, { buffer = bufnr, noremap = true, silent = true, desc = "LSP: [G]oto [R]eferences" })
			end,
			enable_roslyn_analyzers = true,
			organize_imports_on_format = true,
			enable_import_completion = true,
		},
	},
}
