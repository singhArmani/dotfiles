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
