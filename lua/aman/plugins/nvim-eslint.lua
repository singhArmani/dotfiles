return {
	"esmuellert/nvim-eslint",
	dependencies = { "nvim-lua/plenary.nvim" },
	config = function()
		require("nvim-eslint").setup({
			-- Optional: Customize settings here
		})
	end,
}
