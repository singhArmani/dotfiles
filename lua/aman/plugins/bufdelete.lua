return {
	"famiu/bufdelete.nvim",
	config = function()
		vim.keymap.set("n", "<leader>bd", ":Bdelete<CR>", { desc = "Delete buffer without closing window" })
	end,
}
