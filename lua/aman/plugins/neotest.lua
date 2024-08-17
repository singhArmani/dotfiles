return {
	"nvim-neotest/neotest",
	event = { "BufReadPre *.spec.ts", "BufNewFile *.spec.ts" },
	dependencies = {
		"nvim-neotest/nvim-nio",
		"nvim-lua/plenary.nvim",
		"antoinemadec/FixCursorHold.nvim",
		"nvim-treesitter/nvim-treesitter",
		"Issafalcon/neotest-dotnet",
		"nvim-neotest/neotest-jest",
		"thenbe/neotest-playwright",
	},
	config = function()
		-- Run tests in nvim
		require("neotest").setup({
			adapters = {
				-- Jest adapter
				require("neotest-jest")({
					jestCommand = "pnpm test --",
					jestConfigFile = "",
					env = { CI = true },
					cwd = function(path)
						return vim.fn.getcwd()
					end,
				}),

				-- Playwright adapter --
				require("neotest-playwright").adapter({
					options = {
						persist_project_selection = true,
						enable_dynamic_test_discovery = true,
						is_test_file = function(file_path)
							-- Consider files inside the "e2e" folder as test files
							return string.match(file_path, "/e2e/")
						end,
					},
				}),

				-- Dotnet adapter with xUnit attributes
				require("neotest-dotnet")({
					loglevel = 1,
				}),
			},
			consumers = {
				playwright = require("neotest-playwright.consumers").consumers,
			},
		})

		-- General keybindings--
		vim.api.nvim_set_keymap(
			"n",
			"<leader>tt",
			"<cmd>lua require('neotest').run.run()<CR>",
			{ noremap = true, silent = true }
		)
		vim.api.nvim_set_keymap(
			"n",
			"<leader>tf",
			"<cmd>lua require('neotest').run.run(vim.fn.expand('%'))<CR>",
			{ noremap = true, silent = true }
		)
		vim.api.nvim_set_keymap(
			"n",
			"<leader>tl",
			"<cmd>lua require('neotest').run.run_last()<CR>",
			{ noremap = true, silent = true }
		)
		vim.api.nvim_set_keymap(
			"n",
			"<leader>ta",
			"<cmd>lua require('neotest').run.run({ suite = true })<CR>",
			{ noremap = true, silent = true }
		)
		vim.api.nvim_set_keymap(
			"n",
			"<leader>ts",
			"<cmd>lua require('neotest').summary.toggle()<CR>",
			{ noremap = true, silent = true }
		)
		vim.api.nvim_set_keymap(
			"n",
			"<leader>to",
			"<cmd>lua require('neotest').output.open({ enter = true })<CR>",
			{ noremap = true, silent = true }
		)
		vim.api.nvim_set_keymap(
			"n",
			"<leader>tS",
			"<cmd>lua require('neotest').run.stop()<CR>",
			{ noremap = true, silent = true }
		)

		-- Jest Keybindings
		vim.api.nvim_set_keymap(
			"n",
			"<leader>tw",
			"<cmd>lua require('neotest').run.run({ jestCommand = 'npm test -- --watch' })<cr>",
			{}
		)
	end,
}
