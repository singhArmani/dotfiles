vim.cmd("let g:netrw_liststyle = 3")

local opt = vim.opt -- for conciseness

-- line numbers
opt.relativenumber = true -- show relative line numbers
opt.number = true -- shows absolute line number on cursor line (when relative number is on)

-- tabs & indentation
opt.tabstop = 2 -- 2 spaces for tabs (prettier default)
opt.shiftwidth = 2 -- 2 spaces for indent width
opt.expandtab = true -- expand tab to spaces
opt.autoindent = true -- copy indent from current line when starting new one

-- line wrapping
opt.wrap = false -- disable line wrapping

-- search settings
opt.ignorecase = true -- ignore case when searching
opt.smartcase = true -- if you include mixed case in your search, assumes you want case-sensitive

-- cursor line
opt.cursorline = true -- highlight the current cursor line

-- appearance

-- turn on termguicolors for nightfly colorscheme to work
-- (have to use iterm2 or any other true color terminal)
opt.termguicolors = true
opt.background = "dark" -- colorschemes that can be light or dark will be made dark
opt.signcolumn = "yes" -- show sign column so that text doesn't shift

-- backspace
opt.backspace = "indent,eol,start" -- allow backspace on indent, end of line or insert mode start position

-- split windows
opt.splitright = true -- split vertical window to the right
opt.splitbelow = true -- split horizontal window to the bottom

-- turn off swapfile
opt.swapfile = false

opt.scrolloff = 4 -- Keep at least 4 lines below cursor

-- autocompletion suggestion window option heigh
opt.pumheight = 10

-- Highlight yanked text
-- Ref: https://github.com/zed-industries/zed/issues/7311#issuecomment-1929344154
local highlight_group = vim.api.nvim_create_augroup("YankHighlight", { clear = true })
vim.api.nvim_create_autocmd("TextYankPost", {
	callback = function()
		vim.highlight.on_yank()
	end,
	group = highlight_group,
	pattern = "*",
})

-- User command for enabling wrap settings
vim.api.nvim_create_user_command("Wrap", function()
	vim.wo.wrap = true
	vim.wo.linebreak = true
	vim.opt.list = false
end, {})

-- Opens Quickfix for typescript errors
vim.api.nvim_create_user_command("TSCQuickfix", function()
	-- Run the tsc command and capture the output
	local result = vim.fn.systemlist("pnpm tsc --noEmit --pretty false")

	-- Convert the output to quickfix format
	local quickfix_list = {}
	for _, line in ipairs(result) do
		-- Match lines like: src/app.ts(x,y): error TS1234: Message
		local file, lnum, col, message = line:match("([^:]+)%((%d+),(%d+)%)%: (.+)")
		if file and lnum and col and message then
			table.insert(quickfix_list, {
				filename = file,
				lnum = tonumber(lnum),
				col = tonumber(col),
				text = message,
			})
		end
	end

	-- Populate the quickfix list
	vim.fn.setqflist(quickfix_list, "r")
	-- Open the quickfix window
	vim.cmd("copen")
end, {})
