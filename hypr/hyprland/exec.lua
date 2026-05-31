hl.on("hyprland.start", function()
	local cmds = {
		"hyprpaper",
		"waybar",
		"mako",
		"~/scripts/battery-notifier",
		"brightnessctl set 20%",
		"pactl set-sink-volume @DEFAULT_SINK@ 75%",
		"hyprctl setcursor catppuccin-frappe-light-cursors 24",
		"blueman-applet",
		"nm-applet",
		"systemctl --user start hyprpolkitagent",
		"~/scripts/hypr-utils random-wallpaper",
	}

	for _, cmd in ipairs(cmds) do
		hl.dispatch(hl.dsp.exec_cmd(cmd))
	end
end)
