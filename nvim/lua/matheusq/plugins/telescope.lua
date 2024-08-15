return {
	"nvim-telescope/telescope.nvim",
	tag = "0.1.4",
	dependencies = { "nvim-lua/plenary.nvim" },
	config = function()
		local builtin = require("telescope.builtin")
		vim.keymap.set("n", "<leader>ff", builtin.find_files, { silent = true })
		vim.keymap.set("n", "<leader>fr", builtin.resume, { silent = true })
		vim.keymap.set("n", "<leader>fg", builtin.live_grep, { silent = true })
		vim.keymap.set("n", "<leader>fi", builtin.grep_string, { silent = true })
		vim.keymap.set("n", "<leader>ft", builtin.quickfix, { silent = true })

		-- This is your opts table
		require("telescope").setup({
			defaults = {
				vimgrep_arguments = {
					"rg",
					"--color=never",
					"--no-heading",
					"--with-filename",
					"--line-number",
					"--column",
					"--smart-case",
				},
				file_ignore_patterns = { "node_modules", "dist" },
			},
			pickers = {
				find_files = {
					theme = "dropdown", -- Optional: Apply a theme, like 'dropdown'
					previewer = false, -- Disable the preview for find_files picker
					find_command = {
						"fd",
						"--type",
						"f",
						"--hidden",
						"--follow",
						"--exclude",
						".git",
						"--exclude",
						"node_modules",
					},
				},
				live_grep = {
					previewer = true, -- Keep previewer enabled for other pickers if needed
				},
			},
			extensions = {
				["ui-select"] = {
					require("telescope.themes").get_dropdown({}),
				},
			},
		})
		-- To get ui-select loaded and working with telescope, you need to call
		-- load_extension, somewhere after setup function:
		require("telescope").load_extension("ui-select")
	end,
}
