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
				-- list of servers for mason to install.
				-- NOTE: tsgo is intentionally NOT here. Newer mason registries no
				-- longer advertise the tsgo package as an lspconfig server, so
				-- mason-lspconfig rejects it ("not a valid entry in ensure_installed").
				-- Its binary is installed via mason-tool-installer below, and it is
				-- enabled explicitly in lspconfig.lua.
				ensure_installed = {
					"html",
					"cssls",
					"tailwindcss",
					"lua_ls",
					"graphql",
					"emmet_ls",
					"prismals",
					"pyright",
					"typos_lsp", -- code-aware spell/typo checker (replaces harper_ls)
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
					"tsgo", -- JS/TS LSP (TypeScript 7 native) + tsc.nvim's type-checker;
					-- installed by package name here because newer mason registries no
					-- longer expose it as an lspconfig server (see mason-lspconfig above)
				},
			})
		end,
	},
}
