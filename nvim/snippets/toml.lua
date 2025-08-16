---@module "luasnip.loaders."

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

return {
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
}
