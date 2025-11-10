return {
	"neovim/nvim-lspconfig",
	event = { "BufReadPre", "BufNewFile" },
	dependencies = {
		"hrsh7th/cmp-nvim-lsp",
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

		-- mason-lspconfig + cmp capabilities
		local mason_lspconfig = require("mason-lspconfig")
		local cmp_nvim_lsp = require("cmp_nvim_lsp")
		local capabilities = cmp_nvim_lsp.default_capabilities()

		-- Optional: lspconfig util helpers (safe to require; does not use deprecated framework)
		local util_ok, util = pcall(require, "lspconfig.util")

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

				opts.desc = "Show LSP references"
				keymap.set("n", "gR", "<cmd>Telescope lsp_references<CR>", opts)

				opts.desc = "Go to declaration"
				keymap.set("n", "gD", vim.lsp.buf.declaration, opts)

				opts.desc = "Show LSP definitions"
				keymap.set("n", "gd", "<cmd>Telescope lsp_definitions<CR>", opts)

				opts.desc = "Show LSP implementations"
				keymap.set("n", "gi", "<cmd>Telescope lsp_implementations<CR>", opts)

				opts.desc = "Show LSP type definitions"
				keymap.set("n", "gt", "<cmd>Telescope lsp_type_definitions<CR>", opts)

				opts.desc = "See available code actions"
				keymap.set({ "n", "v" }, "<leader>do", vim.lsp.buf.code_action, opts)

				opts.desc = "Smart rename"
				keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)

				opts.desc = "Show buffer diagnostics"
				keymap.set("n", "<leader>D", "<cmd>Telescope diagnostics bufnr=0<CR>", opts)

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

		-- harper_ls
		vim.lsp.config("harper_ls", {
			settings = {
				["harper-ls"] = {
					linters = {
						SpellCheck = true,
						SpelledNumbers = false,
						AnA = false,
						SentenceCapitalization = false,
						UnclosedQuotes = true,
						WrongQuotes = false,
						LongSentences = false,
						RepeatedWords = true,
						Spaces = true,
						Matcher = true,
						CorrectNumberSuffix = true,
					},
					codeActions = { ForceStable = false },
					markdown = { IgnoreLinkTitle = false },
					diagnosticSeverity = "hint",
					isolateEnglish = true,
					dialect = "British",
					maxFileLength = 120000,
				},
			},
			capabilities = capabilities,
		})
		vim.lsp.enable("harper_ls")

		-- oxlint
		vim.lsp.config("oxlint", {
			capabilities = capabilities,
			root_dir = util_ok and util.root_pattern(".oxlintrc.json", "package.json", ".git") or nil,
			-- cmd = { "/Users/aman/.nvm/versions/node/v20.19.0/bin/oxc_language_server" },
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

		-- Everything else via Mason: define minimal configs + enable
		mason_lspconfig.setup_handlers({
			function(server_name)
				if server_name == "lua_ls" or server_name == "harper_ls" or server_name == "oxlint" then
					return -- already configured above
				end
				vim.lsp.config(server_name, {
					capabilities = capabilities,
				})
				vim.lsp.enable(server_name)
			end,
		})
	end,
}
