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
		-- Project-wide Oxlint → Quickfix via :make (robust + simple)
		vim.api.nvim_create_user_command("LintProject", function()
			-- 1) Find a safe root (never nil)
			local function project_root()
				local buf = vim.api.nvim_buf_get_name(0)
				local start_dir = buf ~= "" and vim.fs.dirname(buf) or (vim.uv or vim.loop).cwd()
				local found = vim.fs.find({ ".oxlintrc.json", "package.json", ".git" }, {
					upward = true,
					path = start_dir,
				})[1]
				return found and vim.fs.dirname(found) or (vim.uv or vim.loop).cwd()
			end

			local root = project_root() -- always a string now

			-- 2) Choose command: oxlint or pnpm exec oxlint
			local runner = (vim.fn.executable("oxlint") == 1) and "oxlint"
				or ((vim.fn.executable("pnpm") == 1) and "pnpm exec oxlint" or nil)

			if not runner then
				vim.notify(
					"Oxlint not found. Install `oxlint` or ensure `pnpm exec oxlint` works.",
					vim.log.levels.ERROR
				)
				return
			end

			-- 3) Build makeprg with an inline 'cd ROOT && …' (no lcd, no nil)
			local root_esc = vim.fn.shellescape(root)
			vim.opt.makeprg = table.concat({
				"cd",
				root_esc,
				"&&",
				runner,
				"--format=unix",
				"src",
				"--ignore-pattern",
				"src/api-lib",
				"--ignore-pattern",
				"src/constants/usZipCodeMap.ts",
				"--ignore-pattern",
				"src/constants/airports.ts",
			}, " ")

			-- 4) Basic unix errorformat → file:line:col: message  (fallback: file:line: message)
			vim.opt.errorformat = "%f:%l:%c:%m,%f:%l:%m"

			-- 5) Run and open quickfix
			vim.cmd("silent make | cwindow")
		end, { desc = "Run Oxlint over src/ (project-wide → Quickfix)" })
	end,
}
