return {
	{
		"mfussenegger/nvim-dap",
		dependencies = {
			{ "rcarriga/nvim-dap-ui", opts = {} },
			"mxsdev/nvim-dap-vscode-js",
			{
				"microsoft/vscode-js-debug",
				version = "1.x",
				build = "npm install && npm run compile vsDebugServerBundle && mv dist out",
			},
			"nvim-neotest/nvim-nio",
		},
		config = function()
			local dap, dapui = require("dap"), require("dapui")
			local dap_vscode_js = require("dap-vscode-js")

			dap_vscode_js.setup({
				debugger_path = vim.fn.stdpath("data") .. "/lazy/vscode-js-debug",
				adapters = { "pwa-node", "pwa-chrome" },
			})

			for _, language in ipairs({ "typescript", "javascript", "typescriptreact" }) do
				dap.configurations[language] = {
					{
						-- use nvim-dap-vscode-js's pwa-node debug adapter
						type = "pwa-node",
						-- attach to an already running node process with --inspect flag
						-- default port: 9222
						request = "attach",
						-- allows us to pick the process using a picker
						processId = require("dap.utils").pick_process,
						-- name of the debug action you have to select for this config
						name = "Attach debugger to existing `node --inspect` process",
						-- for compiled languages like TypeScript or Svelte.js
						sourceMaps = true,
						-- resolve source maps in nested locations while ignoring node_modules
						resolveSourceMapLocations = {
							"${workspaceFolder}/**",
							"!**/node_modules/**",
						},
						-- path to src in vite based projects (and most other projects as well)
						cwd = "${workspaceFolder}/src",
						-- we don't want to debug code inside node_modules, so skip it!
						skipFiles = { "${workspaceFolder}/node_modules/**/*.js" },
					},
					{
						type = "pwa-chrome",
						request = "attach",
						name = "Launch Chrome to debug client",
						url = "http://localhost:3000", -- Adjust to your dev server's URL
						webRoot = "${workspaceFolder}/src",
						userDataDir = false,
						-- protocol = "inspector",
						port = 9222,
						-- skip files from vite's hmr
						skipFiles = { "**/node_modules/**/*", "**/@vite/*", "**/src/client/*", "**/src/*" },
					},
				}
			end

			-- Core stepping
			vim.keymap.set("n", "<F5>", dap.continue)
			vim.keymap.set("n", "<F10>", dap.step_over)
			vim.keymap.set("n", "<F11>", dap.step_into)
			vim.keymap.set("n", "<F12>", dap.step_out)

			-- Breakpoints
			vim.keymap.set("n", "<Leader>db", dap.toggle_breakpoint, { desc = "Toggle Breakpoint" })
			vim.keymap.set("n", "<Leader>dB", dap.set_breakpoint, { desc = "Set Breakpoint" })
			vim.keymap.set("n", "<Leader>dt", dapui.toggle, { desc = "Toggle DAP UI" })
			vim.keymap.set("v", "<Leader>de", dapui.eval, { desc = "Evaluate Expression in Visual Mode" })
			vim.keymap.set("n", "<Leader>de", function()
				require("dapui").eval()
				require("dapui").eval()
			end, { desc = "Evaluate expression and focus popup" })

			-- Cursor + Terminate
			vim.keymap.set("n", "<Leader>dn", dap.run_to_cursor, { desc = "Run to Cursor" })
			-- Disconnect debugger (don't kill the app)
			vim.keymap.set("n", "<Leader>dq", dap.disconnect, { desc = "Disconnect Debugger" })

			-- Disconnect and close UI (clean quit)
			vim.keymap.set("n", "<Leader>dx", function()
				dap.disconnect()
				dapui.close()
			end, { desc = "Disconnect + Close UI" })

			dap.listeners.before.attach.dapui_config = function()
				dapui.open()
			end
			dap.listeners.before.launch.dapui_config = function()
				dapui.open()
			end
			dap.listeners.before.event_terminated.dapui_config = function()
				dapui.close()
			end
			dap.listeners.before.event_exited.dapui_config = function()
				dapui.close()
			end

			-- Adapters:
			dap.adapters.coreclr = {
				type = "executable",
				command = "/usr/local/netcoredbg",
				args = { "--interpreter=vscode" },
			}

			dap.configurations.cs = {
				{
					type = "coreclr",
					name = "launch - netcoredbg",
					request = "launch",
					program = function()
						return vim.fn.input("Path to dll", vim.fn.getcwd() .. "/bin/Debug/", "file")
					end,
				},
			}
			dap.configurations.cs = {
				-- Web API Configuration
				{
					name = ".NET Core Launch (web)",
					type = "coreclr",
					request = "launch",
					program = "${workspaceFolder}/Avarni.Api/bin/Debug/net9.0/Avarni.Api.dll",
					cwd = "${workspaceFolder}/Avarni.Api",
					env = {
						ASPNETCORE_ENVIRONMENT = "Development",
						ASPNETCORE_URLS = "http://localhost:5118",
					},
					stopAtEntry = false,
					serverReadyAction = {
						action = "openExternally",
						pattern = "\\bNow listening on:\\s+(https?://\\S+)",
					},
					sourceFileMap = {
						["/Views"] = "${workspaceFolder}/Views",
					},
				},

				-- Worker Project Configuration
				{
					name = ".NET Core Launch (worker)",
					type = "coreclr",
					request = "launch",
					program = "${workspaceFolder}/Avarni.Worker/bin/Debug/net8.0/Avarni.Worker.dll",
					cwd = "${workspaceFolder}/Avarni.Worker",
					env = {
						ASPNETCORE_ENVIRONMENT = "Development",
					},
					stopAtEntry = false,
					sourceFileMap = {
						["/Views"] = "${workspaceFolder}/Views",
					},
				},

				-- Attach Configuration
				{
					name = ".NET Core Attach",
					type = "coreclr",
					request = "attach",
				},

				-- Test Project Configuration
				{
					name = ".NET Core Launch (test)",
					type = "coreclr",
					request = "launch",
					program = "${workspaceFolder}/Avarni.Tests/bin/Debug/net8.0/Avarni.Tests.dll",
					args = {
						"test",
						"${workspaceFolder}/Avarni.Tests/Avarni.Tests.csproj",
						"--no-build",
						"--logger:trx",
					},
					cwd = "${workspaceFolder}/Avarni.Tests",
					stopAtEntry = false,
					console = "internalConsole",
				},
			}
			vim.cmd("highlight DapRed guifg=#E82424")
			vim.fn.sign_define("DapStopped", { text = "➡️", texthl = "Warning", linehl = "Visual", numhl = "" })
			vim.fn.sign_define("DapBreakpoint", { text = "", texthl = "DapRed", linehl = "", numhl = "" })
		end,
	},
}

-- command = vim.fn.stdpath("data") .. "/mason/bin/netcoredbg",
