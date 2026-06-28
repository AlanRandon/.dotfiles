hl.config({
	general = {
		layout = "dwindle",
	},
	input = {
		kb_layout = "gb",
		kb_options = "compose:menu",
		touchpad = {
			natural_scroll = true,
		},
		follow_mouse = 0,
		sensitivity = 0,
	},
	dwindle = {
		preserve_split = true,
	},
	cursor = {
		inactive_timeout = 1,
		hide_on_key_press = true,
		persistent_warps = true,
	},
})

require("hyprland.env")
require("hyprland.exec")
require("hyprland.bind")
require("hyprland.style")

-- waybar hyprland/submap does not appear to work at current
hl.on("keybinds.submap", function(submap)
	hl.exec_cmd(("echo '%s' >/tmp/hyprland-submap && pkill -RTMIN+1 waybar"):format(submap))
end)
