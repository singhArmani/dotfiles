return {
	-- Mason.nvim plugin
	-- Pinned to v1: lspconfig.lua relies on mason-lspconfig's `setup_handlers`,
	-- which was removed in Mason/mason-lspconfig 2.0.
	{
		"mason-org/mason.nvim",
		version = "^1.0.0",
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
		version = "^1.0.0",
		event = { "BufReadPre", "BufNewFile" },
		dependencies = {
			"mason-org/mason.nvim",
		},
		config = function()
			-- import mason-lspconfig
			local mason_lspconfig = require("mason-lspconfig")

			-- Setup mason-lspconfig
			mason_lspconfig.setup({
				-- list of servers for mason to install
				ensure_installed = {
					-- "tsserver", (powered by typescript-tools.nvim)
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
