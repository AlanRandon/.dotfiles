---@class LspProgress
---@field message string
---@field title string
---@field percentage number

---@class LspNotifications
---@field lsp_name string
---@field notification notify.Notification|nil
---@field messages { [lsp.ProgressToken]: LspProgress }

---@type { [integer]: LspNotifications }
local lsp_notifications = {}

local notify = require("notify")

vim.lsp.handlers["$/progress"] = function(_, result, ctx)
	local client_id = ctx.client_id

	local val = result.value
	if not val.kind then
		return
	end

	local name = vim.lsp.get_client_by_id(client_id).name
	if not name then
		return
	end

	if not lsp_notifications[client_id] then
		lsp_notifications[client_id] = {
			lsp_name = name,
			notification = nil,
			messages = {},
		}
	end

	local progress = lsp_notifications[client_id].messages[result.token]
	local notification = lsp_notifications[client_id].notification

	if not progress then
		-- expect val.kind == "begin"
		lsp_notifications[client_id].messages[result.token] = {
			title = val.title,
			percentage = val.percentage,
			message = val.message,
		}
	end

	if val.kind == "report" then
		progress.message = val.message
		progress.percentage = val.percentage
	elseif val.kind == "end" then
		progress.message = "complete"
		progress.percentage = val.percentage
	end

	local message = {}

	for _, value in pairs(lsp_notifications[client_id].messages) do
		local line = value.title:lower()
		if value.message then
			line = string.format("%s: %s", line, value.message)
		end

		if value.percentage then
			line = string.format("%s (%u%%)", line, value.percentage)
		end

		table.insert(message, line)
	end

	lsp_notifications[client_id].notification = notify(message, vim.log.levels.INFO, {
		title = name,
		replace = notification,
		on_close = function()
			lsp_notifications[client_id].notification = nil
		end,
	})

	if val.kind == "end" then
		lsp_notifications[client_id].messages[result.token] = nil
	end
end

local severity = {
	vim.log.levels.ERROR,
	vim.log.levels.WARN,
	vim.log.levels.INFO,
	vim.log.levels.INFO,
}

vim.lsp.handlers["window/showMessage"] = function(err, method, params, client_id)
	notify(method.message, severity[params.type])
end
