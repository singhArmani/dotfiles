return {
	"dmmulroy/tsc.nvim",
	dependencies = { "rcarriga/nvim-notify" },
	config = function()
		require("tsc").setup({
			-- Matches `pnpm check-types` (TS 7 native preview); resolves from node_modules/.bin first.
			bin_name = "tsgo",
		})
	end,
}
