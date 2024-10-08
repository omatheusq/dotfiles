return {
	"pmizio/typescript-tools.nvim",
	event = { "BufReadPost", "BufNewFile" },
	dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
	opts = function()
		local api = require("typescript-tools.api")
		return {
			handlers = {
				-- Filter diagnostics if needed
				["textDocument/publishDiagnostics"] = api.filter_diagnostics({ 80006 }),
			},
			on_attach = function(client, bufnr)
				-- Disable tsserver's formatting if you use another formatter (e.g., Prettier)
				client.server_capabilities.documentFormattingProvider = false
				client.server_capabilities.documentRangeFormattingProvider = false

				-- Keybindings for common LSP functionalities
				local opts = { noremap = true, silent = true, buffer = bufnr }

				vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
				vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
				vim.keymap.set("n", "gt", vim.lsp.buf.type_definition, opts)
				vim.keymap.set("n", "gr", "<cmd>Telescope lsp_references<CR>", opts)
				vim.keymap.set("n", "H", vim.lsp.buf.hover, opts)

				-- Rename symbol
				vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)

				-- Code actions for auto imports (or other actions)
				vim.keymap.set("n", "<CR>", function()
					vim.lsp.buf.code_action({
						filter = function(action)
							return action.title:lower():match("import")
						end,
						apply = true,
					})
				end, opts)
			end,
			settings = {
				separate_diagnostic_server = true, -- Diagnostics handled separately
				tsserver_max_memory = "auto",
				complete_function_calls = false, -- Disable function call snippets
				include_completions_with_insert_text = true,
				publish_diagnostic_on = "insert_leave",
				expose_as_code_action = {
					"fix_all", -- Fix-all issues
					"add_missing_imports", -- Auto import missing items
					"remove_unused", -- Remove unused code
					"remove_unused_imports",
					"organize_imports",
				},
				tsserver_file_preferences = {
					includeInlayParameterNameHints = "literals",
					includeCompletionsForModuleExports = true,
					includeInlayParameterNameHintsWhenArgumentMatchesName = false,
					includeInlayFunctionParameterTypeHints = true,
					includeInlayVariableTypeHints = true,
					includeInlayVariableTypeHintsWhenTypeMatchesName = false,
					includeInlayPropertyDeclarationTypeHints = true,
					includeInlayFunctionLikeReturnTypeHints = true,
					includeInlayEnumMemberValueHints = false,
					quotePreference = "auto",
				},
			},
		}
	end,
}
