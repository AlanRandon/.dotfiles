vim.g.mapleader = " " -- use space as <leader>
vim.g.maplocalleader = " " -- use space as <localleader>

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
