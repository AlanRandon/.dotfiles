---@diagnostic disable: undefined-global

local email = vim.system({ "git", "config", "get", "user.email" }):wait(100).stdout:gsub("\n", "")

local seconds_in_day = 60 * 60 * 24

---@param offset_seconds integer
local function date(offset_seconds)
	local timestamp = vim.fn.localtime() + offset_seconds
	return vim.fn.strftime("%Y-%m-%d", timestamp)
end

return {
	s("mail", t(email)),
	s("email", t(email)),
	s("gh", t("github.com/AlanRandon")),
	s(
		"date",
		f(function()
			return date(0)
		end)
	),
	s(
		{
			trig = "date%+(%d+)",
			trigEngine = "pattern",
			hidden = true,
		},
		f(function(_, snip)
			local offset_days = tonumber(snip.captures[1]) or 0
			return date(offset_days * seconds_in_day)
		end)
	),
	s(
		{
			trig = "date%-(%d+)",
			trigEngine = "pattern",
			hidden = true,
		},
		f(function(_, snip)
			local offset_days = tonumber(snip.captures[1]) or 0
			return date(-offset_days * seconds_in_day)
		end)
	),
}
