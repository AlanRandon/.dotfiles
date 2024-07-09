local ls = require("luasnip")
require("luasnip.loaders.from_vscode").lazy_load()
ls.config.setup()

local s = ls.snippet
local sn = ls.snippet_node
local t = ls.text_node
local i = ls.insert_node
-- local f = ls.function_node
local c = ls.choice_node
-- local d = ls.dynamic_node
-- local r = ls.restore_node
local rep = require("luasnip.extras").rep
-- local fmt = require("luasnip.extras.fmt").fmt

---@param key string
---@param pos integer
local function card_pair(pos, key)
	return c(pos, {
		sn(nil, {
			t(key),
			t({ ' = "' }),
			i(1, key),
			t({ '"', "" }),
		}),
		sn(nil, {
			t(key),
			t({ ' = """', "" }),
			i(1, key),
			t({ "", '"""', "" }),
		}),
		sn(nil, {
			t(key),
			t({ " = { text = '''", "" }),
			i(1, key),
			t({ "", "''', format = \"tex\" }", "" }),
		}),
		sn(nil, {
			t(key),
			t({ " = '''", "" }),
			i(1, key),
			t({ "", "'''", "" }),
		}),
	})
end

ls.add_snippets("toml", {
	s("card", {
		t({ "[[cards]]", "" }),
		card_pair(1, "term"),
		card_pair(2, "definition"),
	}),
	s("lcard", {
		t({ "[[cards]]", "" }),
		t({ "term = '''", "L. " }),
		i(1, "lines"),
		t(' "'),
		i(2, "quote"),
		t({ '"', "'''", "definition = '''", "L. " }),
		rep(1),
		t(' "'),
		i(3, "translation"),
		t({ '"', "" }),
		i(4, "explanation"),
		t({ "", "'''", "" }),
	}),
})

vim.keymap.set({ "i", "s" }, "<C-j>", function()
	ls.jump(1)
end, { silent = true })

vim.keymap.set({ "i", "s" }, "<C-k>", function()
	ls.jump(-1)
end, { silent = true })

vim.keymap.set({ "i", "s" }, "<C-n>", function()
	if ls.choice_active() then
		ls.change_choice(1)
	end
end, { silent = true })

vim.keymap.set({ "i", "s" }, "<C-p>", function()
	if ls.choice_active() then
		ls.change_choice(-1)
	end
end, { silent = true })
