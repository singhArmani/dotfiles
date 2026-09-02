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
				-- exclude, not `true`: the mason registry maps the installed tsgo
				-- package to the lspconfig server of the same name, so automatic_enable
				-- would start it alongside the tsc client lspconfig.lua enables -- two
				-- TS servers on every buffer, and tsgo is the deprecated alias that
				-- warns on init. Everything else installed still auto-enables.
				automatic_enable = { exclude = { "tsgo" } },
				-- list of servers for mason to install.
				-- NOTE: tsgo is intentionally NOT here either. Its binary is installed
				-- via mason-tool-installer below (only as the $PATH fallback for the
				-- tsc server's binary probe outside a project); the server itself is
				-- configured and enabled explicitly, under its new name tsc, in
				-- lspconfig.lua.
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
					-- Postgres LSP (libpg_query -- the real PG parser, so diagnostics
					-- match what the server would say). workspace_required, so it stays
					-- dormant until a project adds postgres-language-server.jsonc; see
					-- the note in lspconfig.lua.
					"postgres_lsp",
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
					"sql-formatter", -- SQL formatter (<leader>mp); see formatting.lua
					"tsgo", -- JS/TS LSP (TypeScript 7 native) + tsc.nvim's type-checker;
					-- installed by package name here because newer mason registries no
					-- longer expose it as an lspconfig server (see mason-lspconfig above)
				},
			})
		end,
	},
}
