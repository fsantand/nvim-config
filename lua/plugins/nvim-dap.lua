return {
	"mfussenegger/nvim-dap",
	event = "LspAttach",
	dependencies = {
		"rcarriga/nvim-dap-ui",
		"williamboman/mason.nvim",
		"jay-babu/mason-nvim-dap.nvim",
		"leoluz/nvim-dap-go",
		"nvim-neotest/nvim-nio",
	},
	config = function()
		local dap = require("dap")
		local dapui = require("dapui")

		require("mason-nvim-dap").setup({
			-- Makes a best effort to setup the various debuggers with
			-- reasonable debug configurations
			automatic_setup = true,

			-- You can provide additional configuration to the handlers,
			-- see mason-nvim-dap README for more information
			handlers = {},

			-- You'll need to check that you have the required things installed
			-- online, please don't ask me how to install them :)
			ensure_installed = {
				-- Update this to ensure that you have the debuggers for the langs you want
				"js-debug-adapter",
			},
		})

		local dap_icons = {
			Stopped = { "󰁕 ", "DiagnosticWarn", "DapStoppedLine" },
			Breakpoint = " ",
			BreakpointCondition = " ",
			BreakpointRejected = { " ", "DiagnosticError" },
			LogPoint = ".>",
		}
		for name, sign in pairs(dap_icons) do
			sign = type(sign) == "table" and sign or { sign }
			vim.fn.sign_define("Dap" .. name, {
				text = sign[1],
				texthl = sign[2] or "DiagnosticInfo",
				linehl = sign[3],
				numhl = sign[3],
			})
		end
		-- Basic debugging keymaps, feel free to change to your liking!
		vim.keymap.set("n", "<F5>", dap.continue, { desc = "Debug: Start/Continue" })
		vim.keymap.set("n", "<F1>", dap.step_into, { desc = "Debug: Step Into" })
		vim.keymap.set("n", "<F2>", dap.step_over, { desc = "Debug: Step Over" })
		vim.keymap.set("n", "<F3>", dap.step_out, { desc = "Debug: Step Out" })
		vim.keymap.set("n", "<leader>b", dap.toggle_breakpoint, { desc = "Debug: Toggle Breakpoint" })
		vim.keymap.set("n", "<leader>B", function()
			dap.set_breakpoint(vim.fn.input("Breakpoint condition: "))
		end, { desc = "Debug: Set Breakpoint" })

		-- Dap UI setup
		-- For more information, see |:help nvim-dap-ui|
		dapui.setup({
			-- Set icons to characters that are more likely to work in every terminal.
			--    Feel free to remove or use ones that you like more! :)
			--    Don't feel like these are good choices.
			icons = { expanded = "▾", collapsed = "▸", current_frame = "*" },
			controls = {
				icons = {
					pause = "⏸",
					play = "▶",
					step_into = "⏎",
					step_over = "⏭",
					step_out = "⏮",
					step_back = "b",
					run_last = "▶▶",
					terminate = "⏹",
					disconnect = "⏏",
				},
			},
		})

		-- Toggle to see last session result. Without this, you can't see session output in case of unhandled exception.
		vim.keymap.set("n", "<F7>", dapui.toggle, { desc = "Debug: See last session result." })

		dap.listeners.after.event_initialized["dapui_config"] = dapui.open
		dap.listeners.before.event_terminated["dapui_config"] = dapui.close
		dap.listeners.before.event_exited["dapui_config"] = dapui.close

		dap.adapters["pwa-node"] = {
			type = "server",
			host = "localhost",
			port = "${port}",
			executable = {
				command = "node",
				args = {
					vim.fn.expand("~/js-debug/src/dapDebugServer.js"),
					"${port}",
				},
			},
		}

		for _, lang in ipairs({ "typescript", "javascript" }) do
			dap.configurations[lang] = {
				{
					type = "pwa-node",
					request = "launch",
					name = "Launch file (Node)",
					program = "${file}",
					cwd = "${workspaceFolder}",
				},
				{
					type = "pwa-node",
					request = "attach",
					name = "Attach",
					skipFiles = {
						"${workspaceFolder}/node_modules/**/*.js",
						"${workspaceFolder}/node_modules/**/*.ts",
					},
					processId = require("dap.utils").pick_process,
					cwd = "${workspaceFolder}",
				},
				{
					type = "pwa-node",
					request = "launch",
					name = "Debug Mocha Tests (TS)",
					-- runtimeExecutable = "node",
					runtimeArgs = {
						"./node_modules/mocha/bin/mocha.js",
						"-u",
						"bdd",
						"--timeout",
						"999999",
					},
					rootPath = "${workspaceFolder}",
					cwd = "${workspaceFolder}",
					console = "integratedTerminal",
					internalConsoleOptions = "neverOpen",
					envFile = "${workspaceFolder}/env/test/.${workspaceFolderBasename}.env",
				},
				{
					type = "pwa-node",
					request = "launch",
					name = "Debug Mocha Tests (TS)",
					-- runtimeExecutable = "node",
					runtimeArgs = {
						"./node_modules/mocha/bin/_mocha.js",
						"-u",
						"bdd",
						"--timeout",
						"999999",
					},
					rootPath = "${workspaceFolder}",
					cwd = "${workspaceFolder}",
					console = "integratedTerminal",
					internalConsoleOptions = "neverOpen",
					envFile = "${workspaceFolder}/env/test/.${workspaceFolderBasename}.env",
				},
				{
					type = 'pwa-node',
					request = 'launch',
					name = "Launch file (Deno)",
					runtimeExecutable = "deno",
					runtimeArgs = {
						"run",
						"--inspect-brk",
						"--allow-all",
						"--log-level=debug",
					},
					program = "${file}",
					cwd = "${workspaceFolder}",
					attachSimplePort = 9229,
				},
			}
		end
	end,
}
