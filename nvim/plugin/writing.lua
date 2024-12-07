-- local null_ls = require("null-ls")

vim.opt.spelllang = "en_gb"
vim.opt.wrap = false

local motions = {
	["<Plug>(WritingUp)"] = { "j", "gj" },
	["<Plug>(WritingDown)"] = { "k", "gk" },
}
local modes = { "n", "v" }

for internal, map in pairs(motions) do
	vim.keymap.set(modes, internal, function()
		vim.cmd("normal " .. map[2])
		vim.fn["repeat#set"](vim.api.nvim_replace_termcodes(internal, true, true, true))
	end)
end

vim.api.nvim_create_user_command("WritingOn", function()
	vim.opt.spell = true
	vim.opt.linebreak = true
	vim.opt.wrap = true
	vim.g.writing_mode = true

	for internal, map in pairs(motions) do
		vim.keymap.set(modes, map[1], internal, { remap = true })
	end

	vim.notify("Writing Mode Enabled")
end, {})

vim.api.nvim_create_user_command("WritingOff", function()
	vim.opt.spell = false
	vim.opt.linebreak = false
	vim.opt.wrap = false
	vim.g.writing_mode = false
	vim.notify("Writing Mode Disabled")

	for _, map in pairs(motions) do
		vim.keymap.del(modes, map[1], {})
	end
end, {})
