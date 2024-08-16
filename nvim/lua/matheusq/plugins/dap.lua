return {
	"rcarriga/nvim-dap-ui",
	dependencies = {
		{ "mfussenegger/nvim-dap" },
		"nvim-neotest/nvim-nio",
		{
			"mxsdev/nvim-dap-vscode-js",
			opts = {
				debugger_path = vim.fn.stdpath("data") .. "/lazy/vscode-js-debug",
				adapters = { "pwa-node", "pwa-chrome", "pwa-msedge", "node-terminal", "pwa-extensionHost" },
			},
		},
		{
			"microsoft/vscode-js-debug",
			version = "1.x",
			build = "rm -rf out/dist && npm ci && npm run compile vsDebugServerBundle && mv dist out",
		},
	},
	keys = {
		{ "<leader>dc", [[:lua require('dap').continue()<cr>]], silent = true },
		{ "<leader>do", [[:lua require('dap').step_over()<cr>]], silent = true },
		{ "<leader>di", [[:lua require('dap').step_into()<cr>]], silent = true },
		{ "<leader>dt", [[:lua require('dap').step_out()<cr>]], silent = true },
		{ "<leader>db", [[:lua require('dap').toggle_breakpoint()<cr>]], silent = true },
		{
			"<leader>dB",
			[[:lua require('dap').set_breakpoint(vim.fn.input('Breakpoint condition: '))<cr>]],
			silent = true,
		},
		{ "<leader>dr", [[:lua require('dap').repl_open()<cr>]], silent = true },
		{ "<leader>du", [[:lua require('dapui').toggle()<cr>]], silent = true },
	},
	config = function()
		local dap = require("dap")
		local dapui = require("dapui")

		dapui.setup()

		local configurations = {
			{
				type = "pwa-node",
				request = "attach",
				name = "Attach debugger to existing `node --inspect` process",
				resolveSourceMapLocations = { "${workspaceFolder}/**", "!**/node_modules/**" },
				cwd = "${workspaceFolder}",
				-- we don't want to debug code inside node_modules, so skip it!
				skipFiles = { "<node_internals>/**", "${workspaceFolder}/node_modules/**" },
			},
			{
				type = "pwa-node",
				request = "launch",
				name = "Launch Node.js program",
				program = "${file}", -- Make sure this file exists and is saved
				cwd = "${workspaceFolder}",
				sourceMaps = true,
				protocol = "inspector",
				skipFiles = { "<node_internals>/**", "${workspaceFolder}/node_modules/**" },
			},
		}
		dap.configurations.javascript = configurations
		dap.configurations.typescript = configurations

		vim.fn.sign_define("DapBreakpoint", { text = "⬤", texthl = "DapBreakpoint", linehl = "", numhl = "" })
		vim.fn.sign_define("DapStopped", { text = "→", texthl = "DapStopped", linehl = "", numhl = "" })

		dap.listeners.after.event_initialized["dapui_config"] = function()
			dapui.open({ reset = true })
		end
		dap.listeners.before.event_terminated["dapui_config"] = dapui.close
		dap.listeners.before.event_exited["dapui_config"] = dapui.close
	end,
}
