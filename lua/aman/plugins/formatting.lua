return {
	"stevearc/conform.nvim",
	event = { "BufReadPre", "BufNewFile" },
	config = function()
		local conform = require("conform")

		conform.setup({
			formatters_by_ft = {
				javascript = { "oxfmt" },
				typescript = { "oxfmt" },
				javascriptreact = { "oxfmt" },
				typescriptreact = { "oxfmt" },
				json = { "oxfmt" },
				svelte = { "prettier" },
				css = { "prettier" },
				html = { "prettier" },
				yaml = { "prettier" },
				markdown = { "prettier" },
				graphql = { "prettier" },
				liquid = { "prettier" },
				lua = { "stylua" },
				python = { "isort", "black" },
				cs = { "csharpier" },
				sql = { "sql_formatter" },
			},
			formatters = {
				-- conform's builtin passes no dialect; sql-formatter then defaults to
				-- generic SQL and mangles Postgres-isms (::casts, $$ bodies, RETURNING).
				-- NOTE: sqlfluff would lint as well as format, but its conform entry sets
				-- require_cwd with a .sqlfluff/pyproject.toml root marker, so it silently
				-- does nothing on an ad-hoc query buffer. postgres_lsp covers linting.
				sql_formatter = {
					prepend_args = { "--language", "postgresql" },
				},
			},
			-- formatters = {
			-- 	csharpier = {
			-- 		command = "dotnet-csharpier", -- The command to run csharpier
			-- 		args = { "--write-stdout" }, -- Arguments passed to the command
			-- 	},
			-- },
			format_on_save = function(bufnr)
				-- Not SQL: in a dadbod-ui query buffer (filetype sql) `:w` executes the
				-- query, so formatting on the way through rewrites the buffer under you
				-- every single run. Format SQL deliberately with <leader>mp instead.
				if vim.bo[bufnr].filetype == "sql" then
					return nil
				end
				return {
					lsp_fallback = true,
					async = false,
					timeout_ms = 1000,
					quiet = true,
				}
			end,
		})

		vim.keymap.set({ "n", "v" }, "<leader>mp", function()
			conform.format({
				lsp_fallback = true,
				async = false,
				timeout_ms = 1000,
			})
		end, { desc = "Format file or range (in visual mode)" })
	end,
}
