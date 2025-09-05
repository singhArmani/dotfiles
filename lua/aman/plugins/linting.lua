return {
	"mfussenegger/nvim-lint",
	event = { "BufReadPre", "BufNewFile" },
	config = function()
		local lint = require("lint")

		-- keep per-file linting if you like
		lint.linters_by_ft = {
			javascript = { "oxlint" },
			javascriptreact = { "oxlint" },
			typescript = { "oxlint" },
			typescriptreact = { "oxlint" },
			python = { "pylint" },
		}

		local grp = vim.api.nvim_create_augroup("lint", { clear = true })
		vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
			group = grp,
			callback = function()
				if lint.linters_by_ft[vim.bo.filetype] then
					lint.try_lint()
				end
			end,
		})

		----------------------------------------------------------------
		-- Project-wide Oxlint → Quickfix
		----------------------------------------------------------------
		vim.api.nvim_create_user_command("LintProject", function()
			-- detect project root (oxlintrc/package.json/.git)
			local root
			local ok, util = pcall(require, "lspconfig.util")
			if ok then
				root = util.root_pattern(".oxlintrc.json", "package.json", ".git")(vim.api.nvim_buf_get_name(0))
			end
			root = root
				or vim.fs.dirname(vim.fs.find({ ".oxlintrc.json", "package.json", ".git" }, { upward = true })[1])
			root = root or vim.loop.cwd()
			vim.cmd("lcd " .. vim.fn.fnameescape(root))

			-- oxlint CLI in unix format is easy for quickfix
			vim.opt.makeprg = table.concat({
				"oxlint",
				"--format=unix",
				"src",
				"--ignore-pattern",
				"src/api-lib",
				"--ignore-pattern",
				"src/constants/usZipCodeMap.ts",
				"--ignore-pattern",
				"src/constants/airports.ts",
			}, " ")

			-- errorformat: file:line:col: message
			vim.opt.errorformat = "%f:%l:%c:%m,%f:%l:%m"

			-- run oxlint, put into quickfix, and open window
			vim.cmd("silent make | cwindow")
		end, { desc = "Run Oxlint over src/ (project-wide → quickfix)" })
	end,
}
