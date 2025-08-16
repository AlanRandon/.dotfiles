---@diagnostic disable: undefined-global

local email = vim.system({ "git", "config", "get", "user.email" }):wait(100).stdout:gsub("\n", "")
return {
	s("date", t(os.date("%Y-%m-%d"))),
	s("mail", t(email)),
	s("email", t(email)),
	s("gh", t("github.com/AlanRandon")),
}
