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
