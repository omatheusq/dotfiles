return {
	"folke/noice.nvim",
	config = function()
		require("noice").setup({
			lsp = {
				signature = {
					enabled = false, -- Disable LSP signature help
				},
				hover = {
					enabled = false, -- Disable LSP hover
				},
				progress = {
					enabled = false, -- Disable LSP progress
				},
			},
			messages = {
				enabled = false, -- Disable message handling
			},
			cmdline = {
				enabled = true, -- Enable cmdline UI
			},
			popupmenu = {
				enabled = false, -- Disable popupmenu handling
			},
			routes = {
				-- Define any custom routes here if needed
			},
		})
	end,
}
