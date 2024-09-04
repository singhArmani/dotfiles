return {
	"akinsho/bufferline.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	version = "*",
	opts = {
		options = {
			mode = "tabs", -- or "buffers" (set buffers if you want to open multiple buffers at same time)
			separator_style = "slant",
			show_buffer_close_icons = false, -- Hides the "x" sign for each buffer
			show_close_icon = false,
		},
	},
}
