return {
	"LunarVim/lunar.nvim",
	config = function()
		local c = require("lunar.palette")
		local hl = vim.api.nvim_set_hl
		c.bg = "#15141b"
		c.bg_highlight = "#192538"
		c.dark3 = "#292e42"
		c.bg_visual = "#292e42"
		c.bg_popup = "#292e42"

		local ok, _ = pcall(vim.cmd, "colorscheme lunar")
		if not ok then
			vim.cmd("colorscheme default") -- if the above fails, then use default
		end
		vim.api.nvim_set_hl(0, "Cursor", { fg = "#000000", bg = "#008b8b" })
	end,
}
