vim.g.mapleader = " " -- use space as <leader>
vim.opt.clipboard = "unnamedplus" -- use system clipboard
vim.opt.relativenumber = true -- use relative line numbers
vim.opt.nu = true -- show the line number of the current line
vim.opt.signcolumn = "yes" -- always show sign column
vim.opt.showmode = false -- mode already in statusline
vim.g.zig_fmt_autosave = false -- zig formatter hangs on save, let the LSP handle this
vim.opt.cursorline = true -- highlight current line
vim.opt.scrolloff = 10 -- keep 10 lines above and below cursor
vim.opt.confirm = true -- confirm closing when not saved rather than aborting command
vim.opt.updatetime = 250

-- show whitespace hints
vim.opt.list = true
vim.opt.listchars = { tab = "» ", trail = "·", nbsp = "␣" }

vim.keymap.set("n", "<ESC>", "<cmd>nohlsearch<CR>", { desc = "Hide Highlight" })
vim.keymap.set({ "n", "v" }, "<leader>d", [["_d]], { desc = "[D]elete Without Yank" })
vim.keymap.set("x", "<leader>p", [["_dP]], { desc = "[P]aste Without Yank" })
vim.keymap.set("t", "<ESC>", "<C-\\><C-n>", { desc = "Escape Terminal Mode" })

vim.keymap.set("n", "<C-h>", "<C-w>h")
vim.keymap.set("n", "<C-j>", "<C-w>j")
vim.keymap.set("n", "<C-k>", "<C-w>k")
vim.keymap.set("n", "<C-l>", "<C-w>l")

vim.keymap.set("n", "<C-u>", "<C-u>zz", { desc = "[U]p Half Page" })
vim.keymap.set("n", "<C-d>", "<C-d>zz", { desc = "[D]own Half Page" })
-- centre window on next/previous item
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

vim.keymap.set("x", " md", ":!prettier --parser markdown<CR>", { desc = "Format [M]ark[d]own Range" })

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
	local lazyrepo = "https://github.com/folke/lazy.nvim.git"
	local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
	if vim.v.shell_error ~= 0 then
		error("Error cloning lazy.nvim:\n" .. out)
	end
end
vim.opt.rtp:prepend(lazypath)

vim.diagnostic.config({
	virtual_text = true,
})

vim.filetype.add({
	extension = {
		wgsl = "wgsl",
	},
})

vim.api.nvim_create_user_command("XdgOpen", function(opts)
	local filepath = require("plenary.path").new(opts.fargs[1]):expand()
	vim.fn.system({ "hyprctl", "keyword", "exec", "xdg-open", filepath })
end, { nargs = 1 })

require("lazy").setup("custom.plugins")
