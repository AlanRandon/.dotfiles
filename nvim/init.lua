-- TODO: Collaborative editing:
-- https://github.com/chipsenkbeil/distant.nvim
-- https://github.com/64-Tesseract/moment

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

vim.g.mapleader = " "
vim.opt.clipboard = "unnamedplus"
vim.opt.updatetime = 50

vim.keymap.set({ "n", "v" }, "<leader>d", [["_d]])
vim.keymap.set("x", "<leader>p", [["_dP]])
vim.keymap.set("t", "<ESC>", "<C-\\><C-n>")

vim.filetype.add({
	extension = {
		wgsl = "wgsl",
	},
})

vim.keymap.set("n", "<C-h>", "<C-w>h")
vim.keymap.set("n", "<C-j>", "<C-w>j")
vim.keymap.set("n", "<C-k>", "<C-w>k")
vim.keymap.set("n", "<C-l>", "<C-w>l")

vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

vim.keymap.set("x", " md", ":!prettier --parser markdown<CR>", { desc = "Format [M]ark[d]own Range" })

vim.opt.nu = true
vim.opt.relativenumber = true
vim.opt.signcolumn = "yes"

vim.g.zig_fmt_autosave = false

vim.diagnostic.config({
	virtual_text = true,
})

vim.api.nvim_create_user_command("XdgOpen", function(opts)
	local filepath = require("plenary.path").new(opts.fargs[1]):expand()
	vim.fn.system({ "hyprctl", "keyword", "exec", "xdg-open", filepath })
end, { nargs = 1 })

require("lazy").setup("custom.plugins")
