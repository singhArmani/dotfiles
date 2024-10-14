return {
	"wincent/ferret",
	config = function()
		vim.keymap.set("n", "'w", ":Ack -w -s <C-R><C-W><CR>", { noremap = true, silent = true })
		vim.keymap.set("n", "'s", ":Ack -w -s ", { noremap = true, silent = true })
		vim.keymap.set("n", "'e", function()
			local search_term = vim.fn.input("Search in test files: ")
			return ":Ack " .. search_term .. " -g *.spec.ts<CR>"
		end, { noremap = true, expr = true })
	end,
}
