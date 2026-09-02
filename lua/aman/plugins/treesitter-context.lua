-- Pins the enclosing function/component/block signature to the top of the
-- window while scrolling inside it. Works with the treesitter `main` branch.
return {
	"nvim-treesitter/nvim-treesitter-context",
	event = { "BufReadPre", "BufNewFile" },
	opts = {
		max_lines = 4, -- cap stacked contexts (deep JSX nesting)
		multiwindow = true,
	},
}
