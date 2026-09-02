-- Pops a panel after <leader> (and g, ], z, ...) listing available keymaps,
-- grouped below. Reads the `desc` field every mapping in this config already
-- sets, so groups here are just labels for the prefixes.
return {
	"folke/which-key.nvim",
	event = "VeryLazy",
	opts = {
		preset = "helix",
		spec = {
			{ "<leader>b", group = "buffers" },
			{ "<leader>c", group = "code" },
			{ "<leader>f", group = "find" },
			{ "<leader>g", group = "git" },
			{ "<leader>h", group = "git hunks" }, -- <leader>h alone is still window-left
			{ "<leader>s", group = "splits" },
			{ "<leader>t", group = "tabs" },
			{ "<leader>u", group = "ui toggles" },
			{ "<leader>x", group = "trouble" },
		},
	},
	keys = {
		{
			"<leader>?",
			function()
				require("which-key").show({ global = false })
			end,
			desc = "Buffer-local keymaps (which-key)",
		},
	},
}
