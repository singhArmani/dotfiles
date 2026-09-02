return {
	"folke/snacks.nvim",
	priority = 1000,
	lazy = false,
	opts = {
		explorer = { enabled = true },
		picker = {
			sources = {
				explorer = {
					layout = { preset = "sidebar", preview = false, layout = { position = "right" } },
					hidden = true, -- show dotfiles
					ignored = false, -- hide gitignored files like node_modules (toggle with 'I')
					git_status = true, -- required for the `ignored` filter to know what's gitignored
					follow_file = true, -- reveal current buffer in tree
					auto_close = true, -- close explorer after opening a file
					win = {
						-- `I`/`H` are only bound in the list window by default, and the input
						-- window's <a-i>/<a-h> never arrive (ghostty sends option as compose).
						-- Bind them in normal mode there too so the toggles work either way.
						input = {
							keys = {
								["I"] = { "toggle_ignored", mode = "n" },
								["H"] = { "toggle_hidden", mode = "n" },
							},
						},
					},
				},
			},
		},
		dashboard = { -- replaces alpha-nvim (startify-style: header + recent files)
			enabled = true,
			preset = {
				header = [[
  ███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗
  ████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║
  ██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║
  ██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║
  ██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║
  ╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝]],
			},
			sections = {
				{ section = "header" },
				{ section = "recent_files", title = "Recent Files", padding = 1 },
				{ section = "keys", gap = 1, padding = 1 },
				{ section = "startup" },
			},
		},
		indent = { -- replaces indent-blankline
			enabled = true,
			indent = { char = "┊" },
		},
		scroll = { enabled = true }, -- replaces neoscroll
		bigfile = { enabled = true }, -- disables TS/LSP heavies on huge files (usZipCodeMap.ts etc.)
		words = { enabled = true }, -- highlight LSP references of symbol under cursor
	},
	keys = {
		{
			"<leader>v",
			function()
				Snacks.explorer()
			end,
			desc = "File Explorer (tree)",
		},
		-- buffer delete (replaces mini.bufremove)
		{
			"<leader>bb",
			function()
				Snacks.bufdelete()
			end,
			desc = "Delete buffer without closing window",
		},
		{
			"<leader>ba",
			function()
				Snacks.bufdelete.other()
			end,
			desc = "Delete all buffers except current one",
		},
		-- zoom (replaces vim-maximizer)
		{
			"<leader>mm",
			function()
				Snacks.zoom()
			end,
			desc = "Maximize/minimize a split",
		},
		-- jump between LSP references (snacks words)
		{
			"]]",
			function()
				Snacks.words.jump(vim.v.count1)
			end,
			desc = "Next reference",
		},
		{
			"[[",
			function()
				Snacks.words.jump(-vim.v.count1)
			end,
			desc = "Prev reference",
		},
	},
}
