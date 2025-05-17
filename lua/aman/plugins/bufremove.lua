return {
	{
		"echasnovski/mini.bufremove",
		version = false, -- Use the latest version
		config = function()
			require("mini.bufremove").setup({
				-- Configuration options (if any)
				set_vim_settings = true, -- Allow hidden buffers
				silent = false, -- Show non-error feedback
			})

			-- Keymapping to delete the current buffer without closing the window
			vim.keymap.set("n", "<leader>bb", function()
				require("mini.bufremove").delete(0, false)
			end, { desc = "Delete buffer without closing window" })

			-- Keymapping to delete all buffers except the current one
			vim.keymap.set("n", "<leader>ba", function()
				local current_buf = vim.api.nvim_get_current_buf()
				for _, buf in ipairs(vim.api.nvim_list_bufs()) do
					if buf ~= current_buf and vim.api.nvim_buf_is_loaded(buf) then
						require("mini.bufremove").delete(buf, false)
					end
				end
			end, { desc = "Delete all buffers except current one" })
		end,
	},
}
