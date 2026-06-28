local M = {
	outputs = { "eDP-1" },
	scale_index = 0,
	scales = { 2.25, 1 },
}

function M.setup(self)
	hl.monitor({
		output = "eDP-1",
		mode = "2880x1800@60.00",
		position = "0x0",
		scale = self.scales[self.scale_index + 1],
	})
end

function M.rotate_scale(self)
	self.scale_index = (self.scale_index + 1) % #self.scales
	hl.monitor({
		output = "eDP-1",
		scale = self.scales[self.scale_index + 1],
	})
end

return M
