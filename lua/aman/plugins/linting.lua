return {
	"mfussenegger/nvim-lint",
	event = { "BufReadPre", "BufNewFile" },
	dependencies = { "folke/trouble.nvim" },
	config = function()
		local lint = require("lint")

		lint.linters_by_ft = {
			python = { "pylint" },
			-- JS/TS: oxlint via oxc_language_server only (see lspconfig oxlint); avoids duplicate runs + tsgolint in nvim-lint
		}

		local grp = vim.api.nvim_create_augroup("lint", { clear = true })
		vim.api.nvim_create_autocmd({ "BufWritePost" }, {
			group = grp,
			callback = function()
				if lint.linters_by_ft[vim.bo.filetype] then
					lint.try_lint()
				end
			end,
		})

		-- :Lint → project-wide oxlint | :Lint! → same with --type-aware (tsgolint; heavier)
		vim.api.nvim_create_user_command("Lint", function(opts)
			local function project_root()
				local buf = vim.api.nvim_buf_get_name(0)
				local start_dir = buf ~= "" and vim.fs.dirname(buf) or (vim.uv or vim.loop).cwd()
				local found = vim.fs.find({ ".oxlintrc.json", "package.json", ".git" }, {
					upward = true,
					path = start_dir,
				})[1]
				return found and vim.fs.dirname(found) or (vim.uv or vim.loop).cwd()
			end

			local root = project_root()
			local src_dir = vim.fn.isdirectory(root .. "/src") == 1 and "src" or "."
			-- Prefer pnpm exec so we use project's local oxlint with .oxlintrc.json
			local runner = (vim.fn.executable("pnpm") == 1 and vim.fn.filereadable(root .. "/package.json") == 1)
					and "pnpm exec oxlint"
				or ((vim.fn.executable("oxlint") == 1) and "oxlint" or nil)

			if not runner then
				vim.notify(
					"Oxlint not found. Install `oxlint` or ensure `pnpm exec oxlint` works.",
					vim.log.levels.ERROR
				)
				return
			end

			local pieces = {
				"cd",
				vim.fn.shellescape(root),
				"&&",
				runner,
			}
			if opts.bang then
				table.insert(pieces, "--type-aware")
			end
			vim.list_extend(pieces, {
				"--format=unix",
				src_dir,
				"--ignore-pattern",
				"src/api-lib",
				"--ignore-pattern",
				"src/client",
				"--ignore-pattern",
				"src/constants/usZipCodeMap.ts",
				"--ignore-pattern",
				"src/constants/airports.ts",
			})
			local cmd = table.concat(pieces, " ")

			local output = vim.fn.system(cmd)
			local qf = {}
			for line in vim.gsplit(output, "\n") do
				-- file:line:col: message (unix format)
				local f, l, c, m = line:match("^([^:]+):(%d+):(%d+):(.+)$")
				if f and l and m then
					local abs_path = f:match("^/") and f or (root .. "/" .. f)
					table.insert(qf, {
						filename = abs_path,
						lnum = tonumber(l),
						col = tonumber(c) or 1,
						text = vim.trim(m),
					})
				end
			end

			vim.fn.setqflist(qf, "r")
			if #qf > 0 then
				vim.cmd("Trouble qflist open")
			else
				vim.notify("No lint issues found", vim.log.levels.INFO)
			end
		end, { bang = true, desc = ":Lint project oxlint | :Lint! adds --type-aware" })
	end,
}
