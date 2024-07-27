-- Uncomment these after adding chatgpt plugin
-- keymap.set("n", "<leader>ai", "<cmd>ChatGPT<CR>", { desc = "Open ChatGPT" })
-- keymap.set("n", "<leader>as", "<cmd>ChatGPTActAs<CR>", { desc = "Set ChatGPT persona" })
-- keymap.set("v", "<leader>ar", "<cmd>ChatGPTRun explain_code<CR>", { desc = "Run ChatGPT with code explanation" })
-- keymap.set("v", "<leader>ad", "<cmd>ChatGPTRun docstring<CR>", { desc = "Run ChatGPT with docstring generation" })
-- keymap.set("n", "<leader>ae", "<cmd>ChatGPTEditWithInstructions<CR>", { desc = "Edit with ChatGPT instructions" })

return {
	"jackMort/ChatGPT.nvim",
	event = "VeryLazy",
	config = function()
		local defaults = {
			--api_key_cmd = "pass show api/tokens/openai",
			yank_register = "+",
			edit_with_instructions = {
				diff = true,
				keymaps = {
					close = "<C-c>",
					accept = "<C-y>",
					toggle_diff = "<C-d>",
					toggle_settings = "<C-o>",
					toggle_help = "<C-h>",
					cycle_windows = "<Tab>",
					use_output_as_input = "<C-i>",
				},
			},
			chat = {
				--welcome_message = WELCOME_MESSAGE,
				loading_text = "Loading, please wait ...",
				question_sign = "", -- 🙂
				answer_sign = "🤖", --
				border_left_sign = "",
				border_right_sign = "",
				max_line_length = 80,
				sessions_window = {
					active_sign = "  ",
					inactive_sign = "  ",
					current_line_sign = "",
					border = {
						style = "rounded",
						text = {
							top = " Sessions ",
						},
					},
					win_options = {
						winhighlight = "Normal:Normal,FloatBorder:FloatBorder",
					},
				},
				keymaps = {
					close = "<C-c>",
					yank_last = "<C-y>",
					yank_last_code = "<C-;>",
					scroll_up = "<C-u>",
					scroll_down = "<C-d>",
					new_session = "<C-n>",
					cycle_windows = "<Tab>",
					cycle_modes = "<C-f>",
					next_message = "<C-]>",
					prev_message = "<C-[>",
					select_session = "<Space>",
					rename_session = "r",
					delete_session = "d",
					draft_message = "<C-r>",
					edit_message = "e",
					delete_message = "d",
					toggle_settings = "<C-o>",
					toggle_sessions = "<C-p>",
					toggle_help = "<C-h>",
					toggle_message_role = "<C-r>",
					toggle_system_role_open = "<C-s>",
					stop_generating = "<C-x>",
				},
			},
			popup_layout = {
				default = "right",
				center = {
					width = "95%",
					height = "95%",
				},
				right = {
					width = "25%", -- default was 30% --
					width_settings_open = "50%",
				},
			},
			popup_window = {
				border = {
					highlight = "FloatBorder",
					style = "rounded",
					text = {
						top = " ChatGPT ",
					},
				},
				win_options = {
					wrap = true,
					linebreak = true,
					foldcolumn = "1",
					winhighlight = "Normal:Normal,FloatBorder:FloatBorder",
				},
				buf_options = {
					filetype = "markdown",
				},
			},
			system_window = {
				border = {
					highlight = "FloatBorder",
					style = "rounded",
					text = {
						top = " SYSTEM ",
					},
				},
				win_options = {
					wrap = true,
					linebreak = true,
					foldcolumn = "2",
					winhighlight = "Normal:Normal,FloatBorder:FloatBorder",
				},
			},
			popup_input = {
				prompt = "  ",
				border = {
					highlight = "FloatBorder",
					style = "rounded",
					text = {
						top_align = "center",
						top = " Prompt ",
					},
				},
				win_options = {
					winhighlight = "Normal:Normal,FloatBorder:FloatBorder",
				},
				submit = "<C-Enter>",
				submit_n = "<Enter>",
				max_visible_lines = 20,
			},
			settings_window = {
				setting_sign = "   ",
				border = {
					style = "rounded",
					text = {
						top = " Settings ",
					},
				},
				win_options = {
					winhighlight = "Normal:Normal,FloatBorder:FloatBorder",
				},
			},
			help_window = {
				setting_sign = " 󰋖 ",
				border = {
					style = "rounded",
					text = {
						top = " Help ",
					},
				},
				win_options = {
					winhighlight = "Normal:Normal,FloatBorder:FloatBorder",
				},
			},
			openai_params = {
				-- model = "gpt-3.5-turbo",
				model = "gpt-4o",
				frequency_penalty = 0,
				presence_penalty = 0,
				max_tokens = 500,
				temperature = 0,
				top_p = 1,
				n = 1,
			},
			openai_edit_params = {
				--model = "gpt-3.5-turbo",
				model = "gpt-4o",
				frequency_penalty = 0,
				presence_penalty = 0,
				temperature = 0,
				top_p = 1,
				n = 1,
			},
			use_openai_functions_for_edits = false,
			actions_paths = {},
			show_quickfixes_cmd = "Trouble quickfix",
			predefined_chat_gpt_prompts = "https://raw.githubusercontent.com/singhArmani/better-chatgpt-prompt/main/avarni-prompts.csv",
			highlights = {
				help_key = "@symbol",
				help_description = "@comment",
			},
		}
		require("chatgpt").setup(defaults)

		-- Keymapping for the chat gpt
		vim.keymap.set("n", "<leader>ai", "<cmd>ChatGPT<CR>", { desc = "Open ChatGPT" })
		vim.keymap.set("n", "<leader>as", "<cmd>ChatGPTActAs<CR>", { desc = "Set ChatGPT persona" })
		vim.keymap.set(
			"v",
			"<leader>ar",
			"<cmd>ChatGPTRun explain_code<CR>",
			{ desc = "Run ChatGPT with code explanation" }
		)
		vim.keymap.set(
			"v",
			"<leader>ad",
			"<cmd>ChatGPTRun docstring<CR>",
			{ desc = "Run ChatGPT with docstring generation" }
		)
		vim.keymap.set(
			"n",
			"<leader>ae",
			"<cmd>ChatGPTEditWithInstructions<CR>",
			{ desc = "Edit with ChatGPT instructions" }
		)
	end,
	dependencies = {
		"MunifTanjim/nui.nvim",
		"nvim-lua/plenary.nvim",
		"folke/trouble.nvim",
		"nvim-telescope/telescope.nvim",
	},
}
