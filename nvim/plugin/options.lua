local o = vim.opt

o.clipboard = "unnamedplus" -- use system clipboard
o.relativenumber = true -- use relative line numbers
o.number = true -- show the line number of the current line
o.signcolumn = "yes" -- always show sign column
o.showmode = false -- mode already in statusline
o.cursorline = true -- highlight current line
o.scrolloff = 10 -- keep 10 lines above and below cursor
o.confirm = true -- confirm closing when not saved rather than aborting command
o.updatetime = 250

o.spelllang = "en_gb"
o.wrap = false

-- show whitespace hints
o.list = true
o.listchars = { tab = "» ", trail = "·", nbsp = "␣" }

-- this is recent: https://github.com/neovim/neovim/pull/25541
if vim.fn.exists("&pumborder") == 1 then
	o.pumborder = "rounded"
end

if vim.fn.exists("&winborder") == 1 then
	o.winborder = "rounded"
end
