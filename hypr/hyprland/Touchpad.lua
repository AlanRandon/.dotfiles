local M = {
	devices = { "uniw0001:00-093a:0255-touchpad" },
	enabled = false,
}

function M.set(self, enabled)
	self.enabled = enabled
	for _, device in ipairs(self.devices) do
		hl.device({ name = device, enabled = self.enabled })
	end
end

function M.toggle(self)
	self:set(not self.enabled)
end

return M
