local M = {}

local function set_window_corner(corner_index)
	local window = hl.get_window("title:^(Picture-in-Picture)$")
	if window == nil then
		return
	end

	local monitor_w, monitor_h = window.monitor.width, window.monitor.height
	local window_w, window_h = window.size.x, window.size.y

	local corner = ({
		{ monitor_w - window_w, 30 },
		{ monitor_w - window_w, monitor_h - window_h },
		{ 0, monitor_h - window_h },
		{ 0, 30 },
	})[corner_index + 1]

	hl.dispatch(hl.dsp.window.move({ x = corner[1], y = corner[2], window = "address:" .. window.address }))
end

local function get_corner(corner_index)
	return ({
		"monitor_w-window_w 30",
		"monitor_w-window_w monitor_h-window_h",
		"0 monitor_h-window_h",
		"0 30",
	})[corner_index + 1]
end

M.current_corner = 0

function M.cycle(self)
	self.current_corner = (self.current_corner + 1) % 4
	self:update()
end

function M.update(self)
	hl.window_rule({
		name = "picture-in-picture",
		match = { class = "firefox", title = "^(Picture-in-Picture)$" },
		float = true,
		pin = true,
		move = get_corner(self.current_corner),
		size = "35% 35%",
		opaque = true,
		border_size = 0,
		rounding = 0,
		no_initial_focus = true,
		no_focus = true,
		tag = "+picture-in-picture",
	})

	set_window_corner(self.current_corner)
end

return M
