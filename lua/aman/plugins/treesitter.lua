-- nvim-treesitter `main` branch (the rewrite).
-- The engine, highlighting, folding and injections now live in Neovim core;
-- this plugin only installs parsers + queries. Requires Neovim 0.12+ and the
-- tree-sitter CLI on PATH (see Brewfile: `brew "tree-sitter"`).
return {
	"nvim-treesitter/nvim-treesitter",
	branch = "main",
	lazy = false, -- the main branch does not support lazy-loading
	build = ":TSUpdate",
	dependencies = {
		"windwp/nvim-ts-autotag",
	},
	config = function()
		-- Keep these parsers installed (async; a no-op if already present).
		require("nvim-treesitter").install({
			"bash",
			"c",
			"c_sharp",
			"css",
			"dockerfile",
			"gitignore",
			"graphql",
			"html",
			"http",
			"javascript",
			"json",
			"lua",
			"markdown",
			"markdown_inline",
			"prisma",
			"query",
			"tsx",
			"typescript",
			"vim",
			"vimdoc",
			"yaml",
		})

		-- Highlighting + (experimental) indentation are core features now; we
		-- just turn them on per-buffer wherever a parser is available. pcall
		-- guards filetypes without an installed parser.
		vim.api.nvim_create_autocmd("FileType", {
			group = vim.api.nvim_create_augroup("nvim_treesitter_start", { clear = true }),
			callback = function(ev)
				if pcall(vim.treesitter.start, ev.buf) then
					vim.bo[ev.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
				end
			end,
		})

		-- Auto close/rename JSX & HTML tags. Configuring autotag through
		-- nvim-treesitter.configs is deprecated on main, so set it up directly.
		require("nvim-ts-autotag").setup()
	end,
}
