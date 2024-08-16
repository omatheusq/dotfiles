vim.opt.nu = true
vim.opt.cursorline = true
vim.opt.relativenumber = true

vim.opt.smartindent = true
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.undofile = true
vim.opt.backup = false
vim.opt.signcolumn = "yes"

vim.o.cmdwinheight = 1
vim.o.cmdheight = 0
vim.opt.guicursor = {
	"n-v-c:block-Cursor", -- Normal, visual, and command mode use block cursor
	"i-ci-ve:block-Cursor", -- Insert and command-line mode use block cursor
	"r:block", -- Replace mode uses block cursor
	"o:block", -- Operator-pending mode uses block cursor
}
