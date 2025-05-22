return {
	{
		"mfussenegger/nvim-dap",
		dependencies = {
			{ "rcarriga/nvim-dap-ui", opts = {} },
			"nvim-neotest/nvim-nio",
		},
		config = function()
			local dap, dapui = require("dap"), require("dapui")

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
