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

