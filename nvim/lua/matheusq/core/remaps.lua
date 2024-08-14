vim.g.mapleader = " "

vim.keymap.set("i", "kj", "<Esc>")

vim.keymap.set("n", "<leader>p", '"_diwP')

vim.keymap.set({ "n", "v" }, "<leader>h", "_")
vim.keymap.set({ "n", "v" }, "<leader>l", "$")

vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]])
vim.keymap.set({ "n", "v" }, "<leader>ip", [["+p]])

vim.keymap.set({ "n", "v", "i" }, "<C-s>", ":silent write<CR> <BAR> :set termguicolors<CR>", { silent = true })

vim.keymap.set("n", "<leader>ca", "<cmd>lua vim.lsp.buf.code_action()<CR>", opts)
