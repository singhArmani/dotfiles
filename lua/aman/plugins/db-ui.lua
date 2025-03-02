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
			{
				name = "uat",
				url = "postgres://avarni_core_api:9EBxHAuaZtxVdcKbogYRPCIx6DSV6W5k@dpg-cnoe8aacn0vc73bgqg6g-a.singapore-postgres.render.com:5432/avarni_core_api",
			},
		}

		-- Set the location to save the connection details
		vim.g.db_ui_save_location = "~/workspace/db_ui"
		vim.keymap.set("n", "<leader>du", ":DBUIToggle<CR>", { noremap = true, silent = true })
	end,
}
