return {
	-- Mason.nvim plugin
	{
		"mason-org/mason.nvim",
		cmd = {
			"Mason",
			"MasonInstall",
			"MasonUninstall",
			"MasonUninstallAll",
			"MasonLog",
			"MasonUpdate",
			"MasonUpdateAll",
		},
		config = function()
			-- import mason
			local mason = require("mason")

			-- enable mason and configure icons
			mason.setup({
				ui = {
					icons = {
						package_installed = "✓",
						package_pending = "➜",
						package_uninstalled = "✗",
					},
				},
			})
		end,
	},

	-- Mason-lspconfig plugin
	{
		"mason-org/mason-lspconfig.nvim",
		event = { "BufReadPre", "BufNewFile" },
		dependencies = {
			"mason-org/mason.nvim",
		},
		config = function()
			-- import mason-lspconfig
			local mason_lspconfig = require("mason-lspconfig")

			-- Setup mason-lspconfig (v2)
			-- `automatic_enable` (default true) calls vim.lsp.enable() for every
			-- installed server, replacing the removed `setup_handlers`. Per-server
			-- settings/capabilities are defined via vim.lsp.config() in lspconfig.lua.
			mason_lspconfig.setup({
				automatic_enable = true,
				-- list of servers for mason to install
				ensure_installed = {
					"tsgo", -- JS/TS LSP (TypeScript 7 native); also tsc.nvim's type-checker
					"html",
					"cssls",
					"tailwindcss",
					"lua_ls",
					"graphql",
					"emmet_ls",
					"prismals",
					"pyright",
				},
			})
		end,
	},

	-- Mason-tool-installer plugin
	{
		"WhoIsSethDaniel/mason-tool-installer.nvim",
		dependencies = {
			"mason-org/mason.nvim",
		},
		config = function()
			-- import mason-tool-installer
			local mason_tool_installer = require("mason-tool-installer")

			-- Setup mason-tool-installer
			mason_tool_installer.setup({
				ensure_installed = {
					"prettier", -- prettier formatter
					"stylua", -- lua formatter
					"isort", -- python formatter
					"black", -- python formatter
					"csharpier", -- csharp formatter
					"pylint", -- python linter
					"oxlint",
				},
			})
		end,
	},
}
