return {
	"mfussenegger/nvim-lint",
	event = { "BufReadPre", "BufNewFile" },
	config = function()
		local lint = require("lint")

		-- 🚫 No JS/TS here – eslint-lsp covers those
		lint.linters_by_ft = {
			python = { "pylint" },
			-- add others you want nvim-lint to handle:
			-- markdown = { "markdownlint" },
			-- dockerfile = { "hadolint" },
			-- yaml = { "yamllint" },
		}

		local grp = vim.api.nvim_create_augroup("lint", { clear = true })

		-- Only run nvim-lint when there is a linter configured for this filetype
		vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
			group = grp,
			callback = function()
				local ft = vim.bo.filetype
				if lint.linters_by_ft[ft] ~= nil then
					lint.try_lint()
				end
			end,
		})
	end,
}
