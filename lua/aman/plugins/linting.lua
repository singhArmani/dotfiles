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

		-- Async ESLint over src/ → populate QUICKFIX (no diagnostics/floats)
		-- after/plugin/lint_qf.lua (or anywhere in your config)
		local function lint_src_to_qf()
			local notify = require("notify")
			local LEVEL = vim.log.levels

			-- spinner frames
			local frames = { "⠋", "⠙", "⠹", "⠸", "⠼", "⠴", "⠦", "⠧", "⠇", "⠏" }
			local fi = 1

			-- single toast, CHAIN updates by reassigning `notif`
			local notif = notify("Linting src/… " .. frames[fi], LEVEL.INFO, {
				title = "Lint",
				timeout = false,
				hide_from_history = true,
			})

			-- animate spinner (replace the SAME toast each tick)
			local t = vim.loop.new_timer()
			t:start(100, 100, function()
				fi = (fi % #frames) + 1
				vim.schedule(function()
					notif = notify("Linting src/… " .. frames[fi], LEVEL.INFO, {
						title = "Lint",
						replace = notif, -- <- replace previous
						hide_from_history = true,
					})
				end)
			end)

			-- run eslint (JSON output)
			local cmd = { "pnpm", "exec", "eslint", "-f", "json", "src" }
			local chunks = {}

			local function finish(msg, level)
				-- stop spinner and replace with final message
				pcall(function()
					t:stop()
					t:close()
				end)
				notif = notify(msg, level, { title = "Lint", replace = notif })
			end

			vim.fn.jobstart(cmd, {
				stdout_buffered = true,
				on_stdout = function(_, data)
					if not data then
						return
					end
					for _, l in ipairs(data) do
						if l ~= "" then
							table.insert(chunks, l)
						end
					end
				end,
				on_exit = function(_, code)
					local text = table.concat(chunks, "\n")
					local ok, json = pcall(vim.json.decode, text)
					local qf = {}

					if ok and type(json) == "table" then
						for _, file in ipairs(json) do
							local fname = file.filePath
							for _, m in ipairs(file.messages or {}) do
								qf[#qf + 1] = {
									filename = fname,
									lnum = m.line or 1,
									col = m.column or 1,
									text = m.message,
									type = (m.severity == 2) and "E" or "W",
								}
							end
						end
					end

					vim.schedule(function()
						vim.fn.setqflist({}, "r", { title = "ESLint (src/)", items = qf })

						if #qf > 0 then
							finish(
								("Lint finished • %d item(s)"):format(#qf),
								(code == 0) and LEVEL.WARN or LEVEL.ERROR
							)
							vim.cmd("copen") -- auto-open quickfix when issues exist
						else
							finish("No ESLint issues found 🎉", LEVEL.INFO)
						end
					end)
				end,
			})
		end

		vim.api.nvim_create_user_command("Lint", lint_src_to_qf, {
			desc = "Run ESLint over src/ (async → quickfix + spinner)",
		})
	end,
}
