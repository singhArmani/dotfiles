return {
	"neovim/nvim-lspconfig",
	event = { "BufReadPre", "BufNewFile" },
	dependencies = {
		"hrsh7th/cmp-nvim-lsp",
		{ "antosha417/nvim-lsp-file-operations", config = true },
		{ "folke/neodev.nvim", opts = {} },
	},
	config = function()
		-- Configure diagnostics with modern signs API
		vim.diagnostic.config({
			virtual_text = false,
			-- virtual_lines = {
			--   only_current_line = true,
			--   highlight_mode = "combine", -- or "replace" for better blending
			-- },
			--
			signs = {
				text = {
					[vim.diagnostic.severity.ERROR] = "",
					[vim.diagnostic.severity.WARN] = "",
					[vim.diagnostic.severity.INFO] = "",
					[vim.diagnostic.severity.HINT] = "󰠠",
				},
			},
		})

		-- Set up diagnostic hover
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
					scope = "line", -- or "cursor"
				})
			end,
		})

		-- Customize the border for hover and signature help (modern way)
		vim.lsp.handlers["textDocument/hover"] = function(_, result, ctx, config)
			config = config or {}
			config.border = "rounded" -- You can use "single", "double", "rounded", "solid", "shadow"
			return vim.lsp.util.open_floating_preview(result.contents, "markdown", config)
		end

		vim.lsp.handlers["textDocument/signatureHelp"] = function(_, result, ctx, config)
			config = config or {}
			config.border = "rounded" -- Use the same border style for signature help
			if not (result and result.signatures and result.signatures[1]) then
				return
			end
			local signature = result.signatures[1]
			local contents = vim.split(signature.label, "\n", { plain = true })
			return vim.lsp.util.open_floating_preview(contents, "markdown", config)
		end

		-- import lspconfig plugin
		local lspconfig = require("lspconfig")

		-- import mason_lspconfig plugin
		local mason_lspconfig = require("mason-lspconfig")

		-- import cmp-nvim-lsp plugin
		local cmp_nvim_lsp = require("cmp_nvim_lsp")

		-- copy diagnostics to clipboard
		local keymap = vim.keymap -- for conciseness
		local function copy_diagnostic_to_clipboard()
			local diagnostics = vim.diagnostic.get(0, { lnum = vim.api.nvim_win_get_cursor(0)[1] - 1 })
			if #diagnostics == 0 then
				vim.notify("No diagnostic message under cursor.", vim.log.levels.INFO)
				return
			end
			local msg = diagnostics[1].message
			vim.fn.setreg("+", msg)
			vim.notify("Diagnostic copied to clipboard!", vim.log.levels.INFO)
		end
		-- end --------

		-- harper_ls setting
		lspconfig.harper_ls.setup({
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
					codeActions = {
						ForceStable = false,
					},
					markdown = {
						IgnoreLinkTitle = false,
					},
					diagnosticSeverity = "hint",
					isolateEnglish = true,
					dialect = "British",
					maxFileLength = 120000,
				},
			},
		})

		vim.api.nvim_create_autocmd("LspAttach", {
			group = vim.api.nvim_create_augroup("UserLspConfig", {}),
			callback = function(ev)
				-- Buffer local mappings.
				-- See `:help vim.lsp.*` for documentation on any of the below functions
				local opts = { buffer = ev.buf, silent = true }

				-- set keybinds
				opts.desc = "Show LSP references"
				keymap.set("n", "gR", "<cmd>Telescope lsp_references<CR>", opts) -- show definition, references

				opts.desc = "Go to declaration"
				keymap.set("n", "gD", vim.lsp.buf.declaration, opts) -- go to declaration

				opts.desc = "Show LSP definitions"
				keymap.set("n", "gd", "<cmd>Telescope lsp_definitions<CR>", opts) -- show lsp definitions

				opts.desc = "Show LSP implementations"
				keymap.set("n", "gi", "<cmd>Telescope lsp_implementations<CR>", opts) -- show lsp implementations

				opts.desc = "Show LSP type definitions"
				keymap.set("n", "gt", "<cmd>Telescope lsp_type_definitions<CR>", opts) -- show lsp type definitions

				opts.desc = "See available code actions"
				keymap.set({ "n", "v" }, "<leader>do", vim.lsp.buf.code_action, opts) -- see available code actions, in visual mode will apply to selection

				opts.desc = "Smart rename"
				keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts) -- smart rename

				opts.desc = "Show buffer diagnostics"
				keymap.set("n", "<leader>D", "<cmd>Telescope diagnostics bufnr=0<CR>", opts) -- show  diagnostics for file

				opts.desc = "Show line diagnostics"
				keymap.set("n", "<leader>d", vim.diagnostic.open_float, opts) -- show diagnostics for line

				opts.desc = "Next diagnostic (skip hints)"
				keymap.set("n", "]d", function()
					vim.diagnostic.jump({ count = 1, severity = { min = vim.diagnostic.severity.WARN } })
				end, opts)

				opts.desc = "Previous diagnostic (skip hints)"
				keymap.set("n", "[d", function()
					vim.diagnostic.jump({ count = -1, severity = { min = vim.diagnostic.severity.WARN } })
				end, opts)

				opts.desc = "Show documentation for what is under cursor"
				keymap.set("n", "K", vim.lsp.buf.hover, opts) -- show documentation for what is under cursor

				opts.desc = "Restart LSP"
				keymap.set("n", "<leader>rs", ":LspRestart<CR>", opts) -- mapping to restart lsp if necessary

				opts.desc = "Copy diagnostic to clipboard"
				keymap.set("n", "<leader>dc", copy_diagnostic_to_clipboard, opts)
			end,
		})

		-- used to enable autocompletion (assign to every lsp server config)
		local capabilities = cmp_nvim_lsp.default_capabilities()

		mason_lspconfig.setup_handlers({
			-- default handler for installed servers
			function(server_name)
				lspconfig[server_name].setup({
					capabilities = capabilities,
				})
			end,
			["lua_ls"] = function()
				-- configure lua server (with special settings)
				lspconfig["lua_ls"].setup({
					capabilities = capabilities,
					settings = {
						Lua = {
							-- make the language server recognize "vim" global
							diagnostics = {
								globals = { "vim" },
							},
							completion = {
								callSnippet = "Replace",
							},
						},
					},
				})
			end,
		})
	end,
}
