return {
	"Exafunction/codeium.vim",
	event = { "InsertEnter", "BufEnter", "BufReadPre", "BufNewFile" },
	config = function()
		-- Enable Codeium
		vim.g.codeium_enabled = true

		-- Define a function to accept Codeium suggestions if available
		local function accept_codeium()
			-- Here, we're checking for the virtual text state.
			local suggestion = vim.fn["codeium#Accept"]()
		end

		-- Set up the Tab key mapping in insert mode
		vim.api.nvim_set_keymap(
			"i",
			"<Tab>",
			"v:lua.accept_codeium_tab()",
			{ expr = true, noremap = true, silent = true }
		)

		vim.keymap.set("i", "<S-tab>", function()
			return vim.fn["codeium#CycleCompletions"](1)
		end, { expr = true, silent = true })

		-- Optionally configure the appearance and behavior of Codeium
		vim.g.codeium_idle_delay = 200 -- Delay in milliseconds before showing suggestions
		vim.g.codeium_suggestion_color = "#808080" -- Customize the color of virtual text

		-- Use autocommand to apply the virtual text color
		vim.api.nvim_create_autocmd("ColorScheme", {
			pattern = "*",
			callback = function()
				vim.cmd("highlight CodeiumSuggestion guifg=" .. vim.g.codeium_suggestion_color)
			end,
		})
	end,
}
