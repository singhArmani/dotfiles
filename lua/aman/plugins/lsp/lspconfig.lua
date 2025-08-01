return {
	"neovim/nvim-lspconfig",
	event = { "BufReadPre", "BufNewFile" },
	dependencies = {
		"hrsh7th/cmp-nvim-lsp",
		{ "antosha417/nvim-lsp-file-operations", config = true },
		{ "folke/neodev.nvim", opts = {} },
	},
	config = function()
		-- vim.diagnostic.config({
		-- 	virtual_text = false,
		-- 	virtual_improved = {
		-- 		current_line = "only",
		-- 	},
		-- 	float = {
		-- 		border = "rounded",
		-- 		header = "",
		-- 		prefix = "",
		-- 	},
		-- })

		-- Configure diagnostics with modern signs API
		vim.diagnostic.config({
			virtual_text = false,
			-- Modern way to configure diagnostic signs (replaces the old sign_define loop)
			signs = {
				text = {
					[vim.diagnostic.severity.ERROR] = " ",
					[vim.diagnostic.severity.WARN] = " ",
					[vim.diagnostic.severity.HINT] = "󰠠 ",
					[vim.diagnostic.severity.INFO] = " ",
				},
			},
		})

		-- Set up diagnostic hover
		-- vim.api.nvim_create_autocmd("CursorHold", {
		-- 	pattern = "*",
		-- 	callback = function()
		-- 		local opts = {
		-- 			focusable = false,
		-- 			close_events = { "BufLeave", "CursorMoved", "InsertEnter", "FocusLost" },
		-- 		}
		-- 		vim.diagnostic.open_float(nil, opts)
		-- 	end,
		-- })
		--
		-- -- Optional: Adjust the hover delay
		-- vim.o.updatetime = 300

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

		local keymap = vim.keymap -- for conciseness

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
				keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts) -- see available code actions, in visual mode will apply to selection

				opts.desc = "Smart rename"
				keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts) -- smart rename

				opts.desc = "Show buffer diagnostics"
				keymap.set("n", "<leader>D", "<cmd>Telescope diagnostics bufnr=0<CR>", opts) -- show  diagnostics for file

				opts.desc = "Show line diagnostics"
				keymap.set("n", "<leader>d", vim.diagnostic.open_float, opts) -- show diagnostics for line

				opts.desc = "Go to previous diagnostic"
				keymap.set("n", "[d", function()
					vim.diagnostic.jump({ count = -1 })
				end, opts) -- jump to previous diagnostic in buffer

				opts.desc = "Go to next diagnostic"
				keymap.set("n", "]d", function()
					vim.diagnostic.jump({ count = 1 })
				end, opts) -- jump to next diagnostic in buffer

				opts.desc = "Show documentation for what is under cursor"
				keymap.set("n", "K", vim.lsp.buf.hover, opts) -- show documentation for what is under cursor

				opts.desc = "Restart LSP"
				keymap.set("n", "<leader>rs", ":LspRestart<CR>", opts) -- mapping to restart lsp if necessary
			end,
		})

		-- used to enable autocompletion (assign to every lsp server config)
		local capabilities = cmp_nvim_lsp.default_capabilities()

		-- REMOVED: Old deprecated sign_define loop
		-- Change the Diagnostic symbols in the sign column (gutter)
		-- (not in youtube nvim video)
		-- local signs = { Error = " ", Warn = " ", Hint = "󰠠 ", Info = " " }
		-- for type, icon in pairs(signs) do
		-- 	local hl = "DiagnosticSign" .. type
		-- 	vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
		-- end

		mason_lspconfig.setup_handlers({
			-- -- Add a custom handler for eslint
			-- ["eslint"] = function()
			-- 	lspconfig.eslint.setup({
			-- 		capabilities = capabilities,
			-- 		flags = {
			-- 			allow_incremental_sync = false,
			-- 			debounce_text_changes = 150,
			-- 		},
			-- 		settings = {
			-- 			workingDirectories = { mode = "auto" },
			-- 		},
			-- 		on_attach = function(client, bufnr)
			-- 			-- Optional: turn off formatting if you use prettier
			-- 			client.server_capabilities.documentFormattingProvider = false
			-- 		end,
			-- 	})
			-- end,
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
