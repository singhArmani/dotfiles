return {
	"rcarriga/nvim-notify",
	opts = {
		timeout = 3000,
		max_width = 80,
		stages = "fade_in_slide_out",
		icons = { ERROR = "", WARN = "", INFO = "" },
	},
	config = function(_, opts)
		require("notify").setup(opts)
		vim.notify = require("notify")
	end,
}
