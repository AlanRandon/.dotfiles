local ls = require("luasnip")
require("luasnip.loaders.from_lua").load({ lazy_paths = vim.fn.stdpath("config") .. "/snippets" })
ls.config.setup()

vim.keymap.set({ "i", "s" }, "<C-n>", function()
	ls.jump(1)
end, { silent = true })

vim.keymap.set({ "i", "s" }, "<C-p>", function()
	if ls.jumpable() then
		ls.jump(-1)
	end
end, { silent = true })

vim.keymap.set({ "i", "s" }, "<C-s><C-n>", function()
	if ls.choice_active() then
		ls.change_choice(1)
	end
end, { silent = true })

vim.keymap.set({ "i", "s" }, "<C-s><C-p>", function()
	if ls.choice_active() then
		ls.change_choice(-1)
	end
end, { silent = true })
