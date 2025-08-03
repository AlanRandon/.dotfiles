local ls = require("luasnip")
require("luasnip.loaders.from_vscode").lazy_load()
ls.config.setup()

local s = ls.snippet
local i = ls.insert_node
local c = ls.choice_node
local r = ls.restore_node
local fmt = require("luasnip.extras.fmt").fmt

---@param key string
---@param pos integer
local function card_value(pos, key)
	return c(pos, {
		fmt([["{}"]], r(1, key)),
		fmt('"""\n{}\n"""', r(1, key)),
		fmt([['{}']], r(1, key)),
		fmt("'''\n{}\n'''", r(1, key)),
		fmt("{{ text = '''\n{}\n''', format = \"typst\" }}", r(1, key)),
		fmt("{{ text = '''\n{}\n''', format = \"tex\" }}", r(1, key)),
	})
end

require("luasnip.session.snippet_collection").clear_snippets("toml")
ls.add_snippets("toml", {
	s(
		"card",
		fmt(
			[=[
[[cards]]
term = {}
definition = {}
]=],
			{
				card_value(1, "term"),
				card_value(2, "definition"),
			}
		),
		{
			stored = {
				["term"] = i(1, "term"),
				["definition"] = i(1, "definition"),
			},
		}
	),
})

require("luasnip.session.snippet_collection").clear_snippets("html")
ls.add_snippets("html", {
	s(
		"html5",
		fmt(
			[[
<!DOCTYPE html>
<html lang="en">
	<head>
		<meta charset="UTF-8">
		<meta name="viewport" content="width=device-width, initial-scale=1.0">
		<title>{}</title>
		<meta name="description" content="{}">
	</head>
	<body>
		{}
	</body>
</html>
]],
			{ i(1, "title"), i(2, "description"), i(3, "body") }
		),
		{ desc = "HTML boilerplate" }
	),
	s(
		"og",
		fmt(
			[[
	<meta property="og:title" content="{}">
	<meta property="og:type" content="website">
	<meta property="og:url" content="{}">
	<meta property="og:description" content="{}">
	<meta property="og:image" content="{}">
	<meta property="og:image:alt" content="{}">
]],
			{
				i(1, "title"),
				i(2, "url"),
				i(3, "description"),
				i(4, "/path/to/image.png"),
				i(5, "image alt text"),
			}
		),
		{ desc = "[Open Graph](https://ogp.me/) metadata" }
	),
})

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

vim.api.nvim_create_user_command("SnippetReload", function()
	vim.cmd.luafile(debug.getinfo(1, "S").source:sub(2))
end, {})
