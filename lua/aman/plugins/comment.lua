-- Native commenting (Neovim 0.10+) provides gc/gcc/gbc out of the box.
-- We keep ts-context-commentstring only to compute the correct commentstring
-- inside embedded languages (e.g. JSX/TSX -> {/* */}, <style> -> /* */).
return {
  "JoosepAlviste/nvim-ts-context-commentstring",
  event = { "BufReadPre", "BufNewFile" },
  init = function()
    -- skip the deprecated backwards-compat module; we drive commenting natively
    vim.g.skip_ts_context_commentstring_module = true
  end,
  config = function()
    require("ts_context_commentstring").setup({
      enable_autocmd = false,
    })

    -- Hook native commenting: have `gc`/`gcc` ask ts-context-commentstring for
    -- the commentstring at the cursor instead of the static buffer option.
    local get_option = vim.filetype.get_option
    vim.filetype.get_option = function(filetype, option)
      return option == "commentstring"
          and require("ts_context_commentstring.internal").calculate_commentstring()
        or get_option(filetype, option)
    end
  end,
}
