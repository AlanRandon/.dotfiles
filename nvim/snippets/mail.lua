---@diagnostic disable: undefined-global

local name = vim.system({ "git", "config", "get", "user.name" }):wait(100).stdout:gsub("\n", "")

return {
	s(
		"msg",
		fmt(
			[[
Hi {},

{}.

Thanks,
{}
]],
			{ i(1, "name"), i(2, "body"), t(name) }
		),
		{ desc = "email body template" }
	),
}
