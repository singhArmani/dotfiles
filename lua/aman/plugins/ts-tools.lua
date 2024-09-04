return {
	"pmizio/typescript-tools.nvim",
	dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
	opts = {
		filetypes = {
			"javascript",
			"javascriptreact",
			"json",
			"jsonc",
			"typescript",
			"typescript.tsx",
			"typescriptreact",
		},
		on_attach = function() end,
		settings = {
			separate_diagnostic_server = true,
			tsserver_max_memory = "auto",
			expose_as_code_action = "all",
			tsserver_plugins = {
				"@styled/typescript-styled-plugin",
			},
			include_completions_with_insert_text = true,
			tsserver_file_preferences = {
				includeInlayParameterNameHints = "all",
				includeCompletionsForModuleExports = true,
				quotePreference = "auto",
				includeInlayEnumMemberValueHints = true,
				includeInlayFunctionLikeReturnTypeHints = true,
				includeInlayVariableTypeHints = true,
			},
			code_lens = "off",
			jsx_close_tag = {
				enable = false,
				filetypes = { "javascriptreact", "typescriptreact" },
			},
		},
	},
}
