return {
	"famiu/bufdelete.nvim",
	config = function()
		vim.keymap.set("n", "<leader>bb", ":Bdelete<CR>", { desc = "Delete buffer without closing window" })
		-- Add new keymapping to delete all buffers except current one
		vim.keymap.set("n", "<leader>ba", function()
			local current_buf = vim.api.nvim_get_current_buf()
			for _, buf in ipairs(vim.api.nvim_list_bufs()) do
				if buf ~= current_buf and vim.api.nvim_buf_is_loaded(buf) then
					vim.api.nvim_buf_delete(buf, { force = true })
				end
			end
		end, { desc = "Delete all buffers except current one" })
	end,
}
