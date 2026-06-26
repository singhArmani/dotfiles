return {
	"kristijanhusak/vim-dadbod-ui",
	dependencies = {
		{ "tpope/vim-dadbod", lazy = true },
		{ "kristijanhusak/vim-dadbod-completion", ft = { "sql", "mysql", "plsql" }, lazy = true }, -- Optional
	},
	cmd = {
		"DBUI",
		"DBUIToggle",
		"DBUIAddConnection",
		"DBUIFindBuffer",
	},
	init = function()
		-- Your DBUI configuration
		-- Enable Nerd Fonts support
		vim.g.db_ui_use_nerd_fonts = 1
		vim.g.db_ui_show_help = 0
		vim.g.db_ui_auto_execute_table_helpers = 1 -- auto execute table query when opening a table
		vim.g.db_ui_win_position = "left"

		-- Define your database connections here
		vim.g.dbs = {
			{
				name = "local",
				url = "postgres://myuser:mypassword@localhost:54320/avarni-db",
			},
		}

		-- UAT (GCP Cloud SQL) is reached through the `uatdb` SSH tunnel:
		-- run `uatdb` first so localhost:5433 maps to the UAT Postgres, then open DBUI.
		-- The password is NOT hardcoded here (this file is committed to a public repo).
		-- Set it in your gitignored secrets file, e.g.:
		--   export UAT_DB_URL="postgres://core_api:<password>@127.0.0.1:5433/app"
		if vim.env.UAT_DB_URL and vim.env.UAT_DB_URL ~= "" then
			table.insert(vim.g.dbs, { name = "uat", url = vim.env.UAT_DB_URL })
		end

		-- Set the location to save the connection details
		vim.g.db_ui_save_location = "~/workspace/db_ui"
		vim.keymap.set("n", "<leader>du", ":DBUIToggle<CR>", { noremap = true, silent = true })
	end,
}
