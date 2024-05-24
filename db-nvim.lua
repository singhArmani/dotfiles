local M = {}

function M.setup()
  -- Enable Nerd Fonts support
  vim.g.db_ui_use_nerd_fonts = 1
  vim.g.db_ui_show_help = 0
  vim.g.db_ui_auto_execute_table_helpers = 1 -- auto execute table query when opening a table
  vim.g.db_ui_win_position = 'right'

  -- Define your database connections here
  vim.g.dbs = {
    dev = 'postgres://myuser:mypassword@localhost:54320/avarni-db',
    -- prod = 'postgres://username:password@localhost:5432/prod_db',
  }

  -- Set the location to save the connection details
  vim.g.db_ui_save_location = "~/.config/nvim/db_ui"
end

return M


