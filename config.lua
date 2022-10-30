-- to hop to any character 
require'hop'.setup()

-- smooth scroll
require('neoscroll').setup()

-- Nvim treesitter config ------------------------------>
require'nvim-treesitter.configs'.setup {
  highlight = {
    enable = true,
    disable = {},
  },
  indent = {
    enable = false,
    disable = {},
  },
  ensure_installed = {
    "tsx",
    "json",
    "yaml",
    "html",
  },
}
local parser_config = require "nvim-treesitter.parsers".get_parser_configs()
parser_config.tsx.used_by = { "javascript", "typescript.tsx" }
-- Nvim treesitter config ends here--------------------->
-- bufferline tab line for neovim
require("bufferline").setup {
  options = {
      show_buffer_close_icons = false,
      show_close_icon = false,
      separator_style = "padded_slant",
  }
}

-- status line for neovim (more faster I guess)
require('lualine').setup {
  options = {
    theme = "tokyonight",
	section_separators = "",
	component_separators = "",
  }
}


-- Nvim tree (file explorer) -------->
-- disable netrw at the very start of your init.lua (strongly advised)
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- For key mapping refers to
-- https://github.com/nvim-tree/nvim-tree.lua/blob/master/doc/nvim-tree-lua.txt 
require("nvim-tree").setup({
  sort_by = "case_sensitive",
  view = {
    adaptive_size = true,
    mappings = {
      list = {
        { key = "u", action = "dir_up" },
      },
    },
  },
  renderer = {
    group_empty = true,
  },
  filters = {
    dotfiles = true,
  },
})
-- Nvim tree (File explorer) ends here-----------------


-- floating terminals --------->
-- Default setup
require("toggleterm").setup{
  	-- size can be a number or function which is passed the current terminal
	-- size = 20 | function(term)
	function(term)
		if term.direction == "horizontal" then
			return 15
		elseif term.direction == "vertical" then
			return vim.o.columns * 0.4
		end
	end,
	open_mapping = [[<C-t>]],
	hide_numbers = false, -- hide the number column in toggleterm buffers
	shade_filetypes = {},
	shade_terminals = true,
	start_in_insert = true,
	insert_mappings = true, -- whether or not the open mapping applies in insert mode
	persist_size = true,
	-- direction = 'vertical' | 'horizontal' | 'window' | 'float',
	direction = "float",
	close_on_exit = true, -- close the terminal window when the process exits
	shell = zsh, -- change the default shell
	-- This field is only relevant if direction is set to 'float'
	float_opts = {
		-- The border key is *almost* the same as 'nvim_open_win'
		-- see :h nvim_open_win for details on borders however
		-- the 'curved' border is a custom border type
		-- not natively supported but implemented in this plugin.
		-- border = 'single' | 'double' | 'shadow' | 'curved' | ... other options supported by win open
		border = 'curved',
		winblend = 3,
		highlights = {
			border = "Normal",
			background = "Normal",
		}
	}
}

-- custom key mapping
function _G.set_terminal_keymaps()
  local opts = {buffer = 0}
  vim.keymap.set('t', 'mt', [[<C-\><C-n>]], opts)
end

-- if you only want these mappings for toggle term use term://*toggleterm#* instead
vim.cmd('autocmd! TermOpen term://* lua set_terminal_keymaps()')

-- lazygit floating terminal
-- Ref: https://github.com/akinsho/toggleterm.nvim
local Terminal  = require('toggleterm.terminal').Terminal
local lazygit = Terminal:new({ cmd = "lazygit", hidden = true, direction = "float" })

function _lazygit_toggle()
  lazygit:toggle()
end

vim.api.nvim_set_keymap("n", "<leader>gg", "<cmd>lua _lazygit_toggle()<CR>", {noremap = true, silent = true})
-- floating terminal ends ----


-- neovim commenter
require('Comment').setup()

