return {
	"RRethy/vim-illuminate",
	event = "BufReadPost",
	opts = { delay = 200 },
	config = function(_, opts)
		require("illuminate").configure(opts)
		local highlights = {
			IlluminatedWord = { bg = "#292e42" },
			IlluminatedCurWord = { bg = "#292e42" },
			IlluminatedWordText = { bg = "#292e42" },
			IlluminatedWordRead = { bg = "#292e42" },
			IlluminatedWordWrite = { bg = "#292e42" },
		}
		for group, value in pairs(highlights) do
			vim.api.nvim_set_hl(0, group, value)
		end
	end,
}
