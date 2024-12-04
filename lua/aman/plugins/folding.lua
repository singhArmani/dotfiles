-- lazy.nvim plugin specification
return {
	"kevinhwang91/nvim-ufo",
	dependencies = {
		"kevinhwang91/promise-async", -- Required dependency
	},
	config = function()
		-- Enable folding with default settings
		vim.o.foldcolumn = "0" -- Show fold column
		vim.o.foldlevel = 99 -- High fold level to keep everything open
		vim.o.foldlevelstart = 99 -- Start with all folds open
		vim.o.foldenable = true -- Enable folding by default

		-- Configure nvim-ufo
		require("ufo").setup({
			provider_selector = function(bufnr, filetype, buftype)
				-- Use Treesitter first, fallback to indent-based folding
				return { "treesitter", "indent" }
			end,
			fold_virt_text_handler = function(virtText, lnum, endLnum, width, truncate)
				-- Custom virtual text for folded lines
				local newVirtText = {}
				local suffix = ("  %d "):format(endLnum - lnum) -- Show folded line count
				local sufWidth = vim.fn.strdisplaywidth(suffix)
				local targetWidth = width - sufWidth
				local curWidth = 0
				for _, chunk in ipairs(virtText) do
					local chunkText = chunk[1]
					local chunkWidth = vim.fn.strdisplaywidth(chunkText)
					if targetWidth > curWidth + chunkWidth then
						table.insert(newVirtText, chunk)
					else
						chunkText = truncate(chunkText, targetWidth - curWidth)
						table.insert(newVirtText, { chunkText, chunk[2] })
						chunkWidth = vim.fn.strdisplaywidth(chunkText)
						curWidth = curWidth + chunkWidth
						if curWidth < targetWidth then
							suffix = suffix .. (" "):rep(targetWidth - curWidth)
						end
						break
					end
					curWidth = curWidth + chunkWidth
				end
				table.insert(newVirtText, { suffix, "MoreMsg" })
				return newVirtText
			end,
		})

		-- Keybindings for folding
		vim.keymap.set("n", "zR", require("ufo").openAllFolds, { desc = "Open all folds" })
		vim.keymap.set("n", "zM", require("ufo").closeAllFolds, { desc = "Close all folds" })
		vim.keymap.set("n", "zr", require("ufo").openFoldsExceptKinds, { desc = "Open folds except some kinds" })
		vim.keymap.set("n", "zm", require("ufo").closeFoldsWith, { desc = "Close folds with specific kinds" })

		-- Toggle folding
		vim.api.nvim_set_keymap("n", "<Space><Space>", "za", { noremap = true, silent = true })
	end,
}
