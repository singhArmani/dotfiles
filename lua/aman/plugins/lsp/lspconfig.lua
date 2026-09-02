return {
	"neovim/nvim-lspconfig",
	event = { "BufReadPre", "BufNewFile" },
	dependencies = {
		"saghen/blink.cmp",
		{ "antosha417/nvim-lsp-file-operations", config = true },
		{ "folke/neodev.nvim", opts = {} },
	},
	config = function()
		-- Diagnostics (modern signs API)
		vim.diagnostic.config({
			virtual_text = false,
			signs = {
				text = {
					[vim.diagnostic.severity.ERROR] = "",
					[vim.diagnostic.severity.WARN] = "",
					[vim.diagnostic.severity.INFO] = "",
					[vim.diagnostic.severity.HINT] = "󰠠",
				},
			},
		})

		-- Diagnostic hover timing
		vim.o.updatetime = 250

		vim.api.nvim_create_autocmd("CursorHold", {
			pattern = "*",
			callback = function()
				vim.diagnostic.open_float(nil, {
					focusable = false,
					close_events = { "BufLeave", "CursorMoved", "InsertEnter", "FocusLost" },
					border = "rounded",
					source = "always",
					prefix = "",
					scope = "line",
				})
			end,
		})

		-- Rounded borders for hover + signatureHelp
		vim.lsp.handlers["textDocument/hover"] = function(_, result, ctx, config)
			config = config or {}
			config.border = "rounded"
			return vim.lsp.util.open_floating_preview(result and result.contents or {}, "markdown", config)
		end

		vim.lsp.handlers["textDocument/signatureHelp"] = function(_, result, _, config)
			config = config or {}
			config.border = "rounded"
			if not (result and result.signatures and result.signatures[1]) then
				return
			end
			local signature = result.signatures[1]
			local contents = vim.split(signature.label or "", "\n", { plain = true })
			return vim.lsp.util.open_floating_preview(contents, "markdown", config)
		end

		-- blink.cmp capabilities applied as the default for every server,
		-- including those auto-enabled by mason-lspconfig (v2 automatic_enable).
		local capabilities = require("blink.cmp").get_lsp_capabilities()
		vim.lsp.config("*", { capabilities = capabilities })

		-- Copy first diagnostic under cursor to clipboard
		local keymap = vim.keymap
		local function copy_diagnostic_to_clipboard()
			local diagnostics = vim.diagnostic.get(0, { lnum = vim.api.nvim_win_get_cursor(0)[1] - 1 })
			if #diagnostics == 0 then
				vim.notify("No diagnostic message under cursor.", vim.log.levels.INFO)
				return
			end
			vim.fn.setreg("+", diagnostics[1].message or "")
			vim.notify("Diagnostic copied to clipboard!", vim.log.levels.INFO)
		end

		-- LspAttach keymaps
		vim.api.nvim_create_autocmd("LspAttach", {
			group = vim.api.nvim_create_augroup("UserLspConfig", {}),
			callback = function(ev)
				local opts = { buffer = ev.buf, silent = true }

				local fzf = require("fzf-lua")

				opts.desc = "Show LSP references"
				keymap.set("n", "gR", fzf.lsp_references, opts)

				opts.desc = "Go to declaration"
				keymap.set("n", "gD", vim.lsp.buf.declaration, opts)

				opts.desc = "Show LSP definitions"
				keymap.set("n", "gd", fzf.lsp_definitions, opts)

				opts.desc = "Show LSP implementations"
				keymap.set("n", "gi", fzf.lsp_implementations, opts)

				opts.desc = "Show LSP type definitions"
				keymap.set("n", "gt", fzf.lsp_typedefs, opts)

				-- Code actions: whole-file request so the menu is never empty and
				-- always includes the aggregates. Two things the default
				-- (cursor-scoped, no `only`) request misses:
				--  * quick-fixes need their diagnostics in the request context, so
				--    pass every buffer diagnostic + a whole-file range;
				--  * tsc only returns its source actions ("Remove Unused Imports",
				--    "Organize Imports", "Sort Imports" — note: its own kind names,
				--    not tsserver's source.removeUnused.ts) when `only` asks for
				--    "source". `only = { quickfix, source }` gets both in one request.
				-- vim.lsp.buf.code_action still renders via fzf-lua (with diff
				-- preview) because fzf-lua is registered as vim.ui.select.
				opts.desc = "See available code actions"
				keymap.set({ "n", "v" }, "<leader>do", function()
					local lsp_diags = {}
					for _, d in ipairs(vim.diagnostic.get(ev.buf)) do
						if d.user_data and d.user_data.lsp then
							table.insert(lsp_diags, d.user_data.lsp)
						end
					end
					vim.lsp.buf.code_action({
						context = {
							diagnostics = lsp_diags,
							only = { "quickfix", "source" },
						},
						range = {
							start = { 1, 0 },
							["end"] = { vim.api.nvim_buf_line_count(ev.buf), 0 },
						},
						-- oxlint offers "Disable <rule> for this line/file" per
						-- diagnostic; with every buffer diagnostic in context that
						-- floods the menu (2 entries × N diagnostics).
						filter = function(action)
							return not (action.title or ""):match("^Disable ")
						end,
					})
				end, opts)

				opts.desc = "Smart rename"
				keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)

				opts.desc = "Show buffer diagnostics"
				keymap.set("n", "<leader>D", fzf.diagnostics_document, opts)

				opts.desc = "Show line diagnostics"
				keymap.set("n", "<leader>d", vim.diagnostic.open_float, opts)

				opts.desc = "Next diagnostic (skip hints)"
				keymap.set("n", "]d", function()
					vim.diagnostic.jump({ count = 1, severity = { min = vim.diagnostic.severity.WARN } })
				end, opts)

				opts.desc = "Previous diagnostic (skip hints)"
				keymap.set("n", "[d", function()
					vim.diagnostic.jump({ count = -1, severity = { min = vim.diagnostic.severity.WARN } })
				end, opts)

				opts.desc = "Show documentation"
				keymap.set("n", "K", vim.lsp.buf.hover, opts)

				opts.desc = "Restart LSP"
				keymap.set("n", "<leader>rs", function()
					vim.lsp.stop_client(vim.lsp.get_clients({ bufnr = ev.buf }))
					vim.cmd("e")
				end, opts)

				opts.desc = "Copy diagnostic to clipboard"
				keymap.set("n", "<leader>dc", copy_diagnostic_to_clipboard, opts)

				-- Inlay hints (tsc/roslyn provide them; see vim.lsp.config below).
				-- Off by default — toggle per buffer when wanted.
				opts.desc = "Toggle inlay hints"
				keymap.set("n", "<leader>uh", function()
					local enabled = vim.lsp.inlay_hint.is_enabled({ bufnr = ev.buf })
					vim.lsp.inlay_hint.enable(not enabled, { bufnr = ev.buf })
				end, opts)
			end,
		})

		-------------------------------------------------------------------
		-- Server configs (new API)
		-------------------------------------------------------------------

		-- oxlint (LSP). typeAware=false: avoids spawning a second tsgolint process
		-- alongside the tsc LSP (was causing ~100% CPU). Type-aware rules (e.g.
		-- no-floating-promises) are available on demand via :Lint!
		-- NOTE: don't override root_dir here. lspconfig's lsp/oxlint.lua resolves the
		-- root by walking up to .oxlintrc.json (handles git worktrees) and launches the
		-- project-local `node_modules/.bin/oxlint --lsp`. The old util.root_pattern() has
		-- the deprecated fun(startpath) signature, which nvim 0.11+ never calls correctly
		-- (it expects fun(bufnr, on_dir)), so the client failed to attach.
		vim.lsp.config("oxlint", {
			capabilities = capabilities,
			settings = {
				typeAware = false, -- tsgolint in-editor doubles CPU; use :Lint! for on-demand type-aware linting
				-- onType is cheap with typeAware=false (ms-fast); the old onSave was
				-- part of the type-aware CPU fight and kept oxc diagnostics/fixes
				-- stale between saves while tsc's updated live.
				run = "onType",
				-- Offer dangerous fixes/suggestions (e.g. no-unused-vars removal) as
				-- quick-fix code actions. Default "safe_fix" hides them. Applying is
				-- still explicit — an action only runs when picked from <leader>ca/do,
				-- and nothing here enables fix-on-save.
				fixKind = "all",
			},
		})
		vim.lsp.enable("oxlint")

		-- lua_ls (special settings)
		vim.lsp.config("lua_ls", {
			capabilities = capabilities,
			settings = {
				Lua = {
					diagnostics = { globals = { "vim" } },
					completion = { callSnippet = "Replace" },
					workspace = { checkThirdParty = false },
				},
			},
		})
		vim.lsp.enable("lua_ls")

		-- tsc (TypeScript 7 native LSP) -- this config was named tsgo until
		-- nvim-lspconfig renamed it; the old name only warns now and is removed in
		-- lspconfig 3.0.0. Enabled explicitly here, and the tsgo alias is excluded
		-- from mason-lspconfig's automatic_enable (see mason.lua) -- the mason
		-- registry maps the installed tsgo package to that server, which would
		-- otherwise start a second TS client on every buffer.
		-- The runtime config (cmd/filetypes/root_dir) comes from nvim-lspconfig's
		-- lsp/tsc.lua, which probes node_modules/.bin/tsc, $PATH tsc,
		-- node_modules/.bin/tsgo, $PATH tsgo and takes the first whose --version
		-- reports TypeScript 7+. In avarni-client that lands on the project-local
		-- tsgo (the `typescript` dep is aliased to typescript6, whose binary is
		-- tsc6, so nothing named tsc exists to shadow it); elsewhere it falls back
		-- to the mason-tool-installer tsgo on $PATH. If no candidate qualifies the
		-- server does not attach at all and it notifies instead.
		-- Inlay hints: lsp/tsc.lua already enables the full inlayHints set; we only
		-- bump parameterNames from the default "literals" to "all" (parity with the
		-- old typescript-tools prefs). The settings namespace must be "js/ts" --
		-- that is the section the server requests; the old tsgo config used
		-- "typescript", which the server now ignores. Hints render only when
		-- toggled on via <leader>uh.
		vim.lsp.config("tsc", {
			settings = {
				["js/ts"] = {
					inlayHints = {
						parameterNames = { enabled = "all" },
					},
				},
			},
		})
		vim.lsp.enable("tsc")

		-- All Mason-installed servers are enabled automatically by
		-- mason-lspconfig's `automatic_enable`, inheriting the vim.lsp.config("*")
		-- defaults above. The servers configured above (oxlint, lua_ls, tsc) and
		-- roslyn (via roslyn.nvim) provide their own per-server overrides.
	end,
}
