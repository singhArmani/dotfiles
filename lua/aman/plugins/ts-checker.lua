return {
	"dmmulroy/tsc.nvim",
	config = function()
		require("tsc").setup({
			-- Matches `pnpm check-types` (TypeScript 7 GA); resolves from node_modules/.bin first.
			bin_name = "tsc",
		})
	end,
}
