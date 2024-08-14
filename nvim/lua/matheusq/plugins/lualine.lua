return {
	"nvim-lualine/lualine.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	config = function()
		local custom_nightfly = require("lualine.themes.nightfly")
		custom_nightfly.normal.c.bg = "#1a1b26"

		require("lualine").setup({
			options = {
				theme = custom_nightfly,
				section_separators = { left = "", right = "" },
			},
			sections = {
				lualine_a = {},
				lualine_b = { "branch", "diff", "diagnostics" },
				lualine_c = { "filename" },
				lualine_x = { "filetype" },
				lualine_y = {},
				lualine_z = {},
			},
			inactive_sections = {
				lualine_a = {},
				lualine_b = {},
				lualine_c = {},
				lualine_x = { "location", "encoding", "fileformat" },
				lualine_y = { "progress" },
				lualine_z = { "location" },
			},
		})
	end,
}
