return {
	"pmizio/typescript-tools.nvim",
	event = { "BufReadPost", "BufNewFile" },
	dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
	opts = function()
		local api = require("typescript-tools.api")
		return {
			handlers = {
				-- Ignore 'This may be converted to an async function' diagnostics.
				["textDocument/publishDiagnostics"] = api.filter_diagnostics({ 80006 }),
			},
			on_attach = function(client)
				client.server_capabilities.documentFormattingProvider = false
				client.server_capabilities.documentRangeFormattingProvider = false

				local opts = { noremap = true, silent = true }

				vim.keymap.set("n", "<leader>rn", "<cmd>lua vim.lsp.buf.rename()<CR>", opts)
				-- vim.keymap.set("n", "<leader>ca", "<cmd>lua vim.lsp.buf.code_action()<CR>", opts)

				-- Autocommand to add missing imports after saving the buffer
				vim.api.nvim_create_autocmd("BufWritePost", {
					pattern = "*.ts,*.tsx", -- Adjust the pattern if needed
					callback = function()
						vim.cmd("TSToolsAddMissingImports")
					end,
				})
			end,
			settings = {
				publish_diagnostic_on = "insert_leave",
				expose_as_code_action = {
					"fix_all",
					"add_missing_imports",
					"remove_unused",
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
