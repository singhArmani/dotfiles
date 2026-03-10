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
			},
			-- formatters = {
			-- 	csharpier = {
			-- 		command = "dotnet-csharpier", -- The command to run csharpier
			-- 		args = { "--write-stdout" }, -- Arguments passed to the command
			-- 	},
			-- },
			format_on_save = {
				lsp_fallback = true,
				async = false,
				timeout_ms = 1000,
				quiet = true,
			},
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
