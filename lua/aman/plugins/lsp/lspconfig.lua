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

				opts.desc = "See available code actions"
				keymap.set({ "n", "v" }, "<leader>do", fzf.lsp_code_actions, opts)

				-- Whole-file code actions: tsserver-family servers (tsgo) only
				-- return import quick-fixes when the diagnostics are passed in the
				-- request context. The default (cursor-scoped) request only includes
				-- diagnostics under the cursor, so "Add all missing imports" etc.
				-- need every buffer diagnostic + a whole-file range.
				opts.desc = "Code actions (whole file)"
				keymap.set("n", "<leader>ca", function()
					local lsp_diags = {}
					for _, d in ipairs(vim.diagnostic.get(ev.buf)) do
						if d.user_data and d.user_data.lsp then
							table.insert(lsp_diags, d.user_data.lsp)
						end
					end
					vim.lsp.buf.code_action({
						context = { diagnostics = lsp_diags },
						range = {
							start = { 1, 0 },
							["end"] = { vim.api.nvim_buf_line_count(ev.buf), 0 },
						},
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
				keymap.set("n", "<leader>rs", ":LspRestart<CR>", opts)

				opts.desc = "Copy diagnostic to clipboard"
				keymap.set("n", "<leader>dc", copy_diagnostic_to_clipboard, opts)
			end,
		})

		-------------------------------------------------------------------
		-- Server configs (new API)
		-------------------------------------------------------------------

		-- oxlint (LSP). Type-aware rules ON: catches rules that need type info,
		-- e.g. no-floating-promises (the "void a fire-and-forget promise" rule).
		-- This spawns tsgolint + tsgo, so it roughly doubles oxlint's RAM/CPU —
		-- acceptable on this machine (M-series, 24GB).
		-- NOTE: don't override root_dir here. lspconfig's lsp/oxlint.lua resolves the
		-- root by walking up to .oxlintrc.json (handles git worktrees) and launches the
		-- project-local `node_modules/.bin/oxlint --lsp`. The old util.root_pattern() has
		-- the deprecated fun(startpath) signature, which nvim 0.11+ never calls correctly
		-- (it expects fun(bufnr, on_dir)), so the client failed to attach.
		vim.lsp.config("oxlint", {
			capabilities = capabilities,
			settings = {
				typeAware = true, -- run type-aware rules (tsgolint) in-editor
				run = "onType",
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

		-- tsgo (TypeScript 7 native LSP). Enabled explicitly rather than via
		-- mason-lspconfig's automatic_enable: newer mason registries no longer
		-- expose tsgo as an lspconfig server, so automatic_enable skips it. The
		-- runtime config (cmd/filetypes/root_dir) is shipped by nvim-lspconfig's
		-- lsp/tsgo.lua; the binary is project-local node_modules/.bin/tsgo, falling
		-- back to the mason-tool-installer one.
		vim.lsp.enable("tsgo")

		-- All Mason-installed servers are enabled automatically by
		-- mason-lspconfig's `automatic_enable`, inheriting the vim.lsp.config("*")
		-- defaults above. The servers configured above (oxlint, lua_ls, tsgo) and
		-- roslyn (via roslyn.nvim) provide their own per-server overrides.
	end,
}
