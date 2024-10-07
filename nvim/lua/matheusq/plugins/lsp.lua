return {
	"neovim/nvim-lspconfig",
	event = { "BufReadPre", "BufNewFile" },
	dependencies = {
		"hrsh7th/cmp-nvim-lsp",
		{ "antosha417/nvim-lsp-file-operations", config = true },
	},
	config = function()
		-- import lspconfig plugin
		local lspconfig = require("lspconfig")

		-- import cmp-nvim-lsp plugin
		local cmp_nvim_lsp = require("cmp_nvim_lsp")

		local keymap = vim.keymap -- for conciseness

		local opts = { noremap = true, silent = true }
		local on_attach = function(client, bufnr)
			opts.buffer = bufnr

			-- set keybinds
			opts.desc = "Show LSP references"
			keymap.set("n", "gr", "<cmd>Telescope lsp_references<CR>", opts) -- show definition, references

			opts.desc = "Go to declaration"
			keymap.set("n", "gD", vim.lsp.buf.declaration, opts) -- go to declaration

			opts.desc = "Go to definition"
			keymap.set("n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", opts)
			--
			-- opts.desc = "See available code actions"
			-- keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts) -- see available code actions, in visual mode will apply to selection
			--
			-- opts.desc = "Smart rename"
			-- keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts) -- smart rename
			--
			-- opts.desc = "Show buffer diagnostics"
			-- keymap.set("n", "<leader>D", "<cmd>Telescope diagnostics bufnr=0<CR>", opts) -- show  diagnostics for file
			--
			-- opts.desc = "Show line diagnostics"
			-- keymap.set("n", "<leader>d", vim.diagnostic.open_float, opts) -- show diagnostics for line
			--
			-- opts.desc = "Go to previous diagnostic"
			-- keymap.set("n", "[d", vim.diagnostic.goto_prev, opts) -- jump to previous diagnostic in buffer
			--
			-- opts.desc = "Go to next diagnostic"
			-- keymap.set("n", "]d", vim.diagnostic.goto_next, opts) -- jump to next diagnostic in buffer
			--
			-- opts.desc = "Show documentation for what is under cursor"
			-- keymap.set("n", "H", vim.lsp.buf.hover, opts) -- show documentation for what is under cursor
			--
			-- opts.desc = "Restart LSP"
			-- keymap.set("n", "<leader>rs", ":LspRestart<CR>", opts) -- mapping to restart lsp if necessary
		end

		-- used to enable autocompletion (assign to every lsp server config)
		local capabilities = cmp_nvim_lsp.default_capabilities()

		-- Change the Diagnostic symbols in the sign column (gutter)
		-- (not in youtube nvim video)
		local signs = { Error = " ", Warn = " ", Hint = "󰠠 ", Info = " " }
		for type, icon in pairs(signs) do
			local hl = "DiagnosticSign" .. type
			vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
		end

		-- configure html server
		lspconfig["html"].setup({
			capabilities = capabilities,
			on_attach = on_attach,
		})

		--configure typescript server with plugin
		lspconfig["tsserver"].setup({
			capabilities = capabilities,
			on_attach = on_attach,
			settings = {
				diagnostics = { ignoredCodes = { 6133 } },
			},
		})

		-- configure css server
		lspconfig["cssls"].setup({
			capabilities = capabilities,
			on_attach = on_attach,
		})

		-- configure emmet language server
		lspconfig["emmet_ls"].setup({
			capabilities = capabilities,
			on_attach = on_attach,
			filetypes = { "html", "typescriptreact", "javascriptreact", "css", "sass", "scss", "less", "svelte" },
		})

		-- configure lua server (with special settings)
		lspconfig["lua_ls"].setup({
			capabilities = capabilities,
			on_attach = on_attach,
			settings = { -- custom settings for lua
				Lua = {
					-- make the language server recognize "vim" global
					diagnostics = {
						globals = { "vim" },
					},
					workspace = {
						-- make language server aware of runtime files
						library = {
							[vim.fn.expand("$VIMRUNTIME/lua")] = true,
							[vim.fn.stdpath("config") .. "/lua"] = true,
						},
					},
				},
			},
		})

		lspconfig["lua_ls"].setup({
			on_attach = on_attach,
			capabilities = capabilities,
			cmd = { "gopls" },
			filetypes = { "go", "gomod", "gowork", "gotmpl" },
			root_dir = require("lspconfig.util").root_pattern("go.work", "go.mod", ".git"),
			settings = {
				gopls = {
					completeUnimported = true,
					usePlaceholders = true,
					analyses = {
						unusedparams = true,
					},
				},
			},
		})

		local function filter_tsserver_diagnostics(_, result, ctx, config)
			if result.diagnostics == nil then
				return
			end
			-- ignore some tsserver diagnostics
			local idx = 1
			while idx <= #result.diagnostics do
				local entry = result.diagnostics[idx]
				-- codes: https://github.com/microsoft/TypeScript/blob/main/src/compiler/diagnosticMessages.json
				if entry.code == 80001 then
					-- { message = "File is a CommonJS module; it may be converted to an ES module.", }
					table.remove(result.diagnostics, idx)
				else
					idx = idx + 1
				end
			end
			vim.lsp.diagnostic.on_publish_diagnostics(_, result, ctx, config)
		end

		vim.lsp.handlers["textDocument/publishDiagnostics"] = filter_tsserver_diagnostics
		--vim.diagnostic.config = filter_tsserver_diagnostics
	end,
}
