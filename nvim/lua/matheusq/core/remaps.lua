vim.g.mapleader = " "

-- vim.keymap.set("i", "kj", "<Esc>")

vim.keymap.set("n", "<leader>p", '"_diwP')

vim.keymap.set({ "n", "v" }, "<leader>h", "_")
vim.keymap.set({ "n", "v" }, "<leader>l", "$")

vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]])
vim.keymap.set({ "n", "v" }, "<leader>ip", [["+p]])

vim.keymap.set({ "n", "v", "i" }, "<C-s>", ":silent write<CR> <BAR> :set termguicolors<CR>", { silent = true })

vim.keymap.set("n", "<leader>ca", "<cmd>lua vim.lsp.buf.code_action()<CR>", opts)

vim.keymap.set("n", "<leader>r", function()
	local word = vim.fn.expand("<cword>")
	vim.api.nvim_input(":<C-u>%s/\\v(" .. word .. ")/" .. word .. "/gI<Left><Left><Left>")
end, { desc = "Replace word under cursor" })

vim.keymap.set("x", "<leader>r", function()
	vim.cmd('normal! "vy')
	local yanked_text = vim.fn.getreg("v")
	yanked_text = yanked_text:gsub("\n", "")
	yanked_text = yanked_text:match("^%s*(.-)%s*$")
	yanked_text = vim.fn.escape(yanked_text, "/\\^$.*+?()[]{}|")

	vim.api.nvim_input(":<C-u>" .. "%s/\\v(" .. yanked_text .. ")/" .. yanked_text .. "/gI<Left><Left><Left>")
end, { desc = "Replace selected text", noremap = true, silent = true })

vim.keymap.set({ "n" }, "<leader><leader>", ":silent write<CR> <BAR> :set termguicolors<CR>", { silent = true })

-- Custom function to select inside quotes or single quotes
local function select_inside_quotes()
	local col = vim.fn.col(".")
	local line = vim.fn.getline(".")

	-- Check if the cursor is inside single or double quotes
	local in_single = line:find("'", col)
	local in_double = line:find('"', col)

	if in_single and (not in_double or in_single < in_double) then
		vim.cmd("normal! vi'")
	elseif in_double then
		vim.cmd('normal! vi"')
	end
end

vim.keymap.set("n", "<leader>q", select_inside_quotes, { silent = true })
-- Map the function to a key in visual mode
