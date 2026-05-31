local main_mod = "SUPER"

hl.bind(main_mod .. " + RETURN", hl.dsp.exec_cmd("ghostty"))
hl.bind(main_mod .. " + B", hl.dsp.exec_cmd("firefox"))
hl.bind(main_mod .. " + D", hl.dsp.exec_cmd("fuzzel"))

local direction_keys = {
	left = "H",
	down = "J",
	up = "K",
	right = "L",
}

for direction, key in pairs(direction_keys) do
	hl.bind(main_mod .. "+" .. key, hl.dsp.focus({ direction = direction }))
	hl.bind(main_mod .. "+ CTRL +" .. key, hl.dsp.window.move({ direction = direction }))
end

hl.bind(main_mod .. "+ Q", hl.dsp.window.close())
hl.bind(main_mod .. "+ F", hl.dsp.window.fullscreen())

for i = 1, 9 do
	hl.bind(main_mod .. "+" .. i, hl.dsp.focus({ workspace = i }))
	hl.bind(main_mod .. "+ SHIFT +" .. i, hl.dsp.window.move({ workspace = i }))
end

hl.bind(main_mod .. " + SHIFT + SPACE", hl.dsp.window.float())

hl.bind(main_mod .. "+ R", hl.dsp.submap("<D-R>"))
hl.define_submap("<D-R>", function()
	hl.bind(direction_keys.up, hl.dsp.window.resize({ x = 0, y = -10, relative = true }), { repeating = true })
	hl.bind(direction_keys.down, hl.dsp.window.resize({ x = 0, y = 10, relative = true }), { repeating = true })
	hl.bind(direction_keys.left, hl.dsp.window.resize({ x = -10, y = 0, relative = true }), { repeating = true })
	hl.bind(direction_keys.right, hl.dsp.window.resize({ x = 10, y = 0, relative = true }), { repeating = true })
	hl.bind("catchall", hl.dsp.submap("reset"))
end)

local Touchpad = require("hyprland.Touchpad")
Touchpad:set(false)

local PictureInPicture = require("hyprland.PictureInPicture")

hl.bind(main_mod .. "+ SPACE", hl.dsp.submap("<D-space>"))
hl.define_submap("<D-space>", "reset", function()
	hl.bind("N", hl.dsp.exec_cmd("ghostty -e impala"))
	hl.bind("V", hl.dsp.exec_cmd("ghostty -e pulsemixer"))
	hl.bind("B", hl.dsp.exec_cmd("ghostty -e ~/scripts/run-bluetui"))

	hl.bind("T", function()
		Touchpad:toggle()
		if Touchpad.enabled then
			hl.dispatch(hl.dsp.exec_cmd("notify-send 'Touchpad Enabled'"))
		else
			hl.dispatch(hl.dsp.exec_cmd("notify-send 'Touchpad Disabled'"))
		end
	end)

	hl.bind("E", hl.dsp.exec_cmd("~/scripts/hypr-utils pick-emoji"))
	hl.bind("W", hl.dsp.exec_cmd("~/scripts/hypr-utils random-wallpaper"))
	hl.bind(main_mod .. "+ W", hl.dsp.exec_cmd("~/scripts/hypr-utils choose-wallpaper"))
	hl.bind("SPACE", hl.dsp.exec_cmd("waybar -c ~/.config/waybar/overlay.jsonc & pid=$! && sleep 2 && kill $pid"))

	hl.bind(main_mod .. "+ P", function()
		PictureInPicture:cycle()
	end)
	hl.bind("catchall", hl.dsp.submap("reset"))
end)

hl.bind(main_mod .. "+ M", hl.dsp.submap("<D-m>"))
hl.define_submap("<D-m>", "reset", function()
	hl.bind("SPACE", hl.dsp.exec_cmd("playerctl play-pause"))
	hl.bind("H", hl.dsp.exec_cmd("playerctl position 5-"))
	hl.bind("L", hl.dsp.exec_cmd("playerctl position 5+"))
	hl.bind("N", hl.dsp.exec_cmd("playerctl next"))
	hl.bind("P", hl.dsp.exec_cmd("playerctl previous"))
	hl.bind(main_mod .. "+ P", hl.dsp.exec_cmd("~/scripts/music-playlist-loadfile"))
	hl.bind("F", hl.dsp.exec_cmd("~/scripts/music-playlist-fuzzy"))
	hl.bind("Q", hl.dsp.exec_cmd("~/scripts/music-playlist-queue"))
	hl.bind("U", hl.dsp.exec_cmd("~/scripts/music-playlist-upcoming"))
	hl.bind("S", hl.dsp.exec_cmd("~/scripts/music-playlist-reshuffle"))
	hl.bind(main_mod .. "+ S", hl.dsp.exec_cmd("~/scripts/music-playlist-unshuffle"))
	hl.bind("catchall", hl.dsp.submap("reset"))
end)

hl.bind("XF86AudioPlay", hl.dsp.exec_cmd("playerctl play-pause"), { submap_universal = true })
hl.bind("XF86AudioPrev", hl.dsp.exec_cmd("playerctl previous"), { submap_universal = true })
hl.bind("XF86AudioNext", hl.dsp.exec_cmd("playerctl next"), { submap_universal = true })

hl.bind("XF86MonBrightnessUp", hl.dsp.exec_cmd("brightnessctl set 5%+"), { submap_universal = true })
hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd("brightnessctl set 5%-"), { submap_universal = true })

local round_sink = hl.dsp.exec_cmd(
	'pactl get-sink-volume @DEFAULT_SINK@ | awk \'NR==1{print(sprintf("%.0f",$5/5)*5)"%"}\' | xargs pactl set-sink-volume @DEFAULT_SINK@'
)

hl.bind("XF86AudioRaiseVolume", function()
	hl.dispatch(hl.dsp.exec_cmd("pactl set-sink-volume @DEFAULT_SINK@ +5%"))
	hl.dispatch(round_sink)
end, { submap_universal = true })

hl.bind("XF86AudioLowerVolume", function()
	hl.dispatch(hl.dsp.exec_cmd("pactl set-sink-volume @DEFAULT_SINK@ -5%"))
	hl.dispatch(round_sink)
end, { submap_universal = true })

hl.bind("XF86AudioMute", function()
	hl.dispatch(hl.dsp.exec_cmd("pactl set-sink-mute @DEFAULT_SINK@ toggle"))
end, { submap_universal = true })

local round_source = hl.dsp.exec_cmd(
	'pactl get-source-volume @DEFAULT_SOURCE@ | awk \'NR==1{print(sprintf("%.0f",$5/5)*5)"%"}\' | xargs pactl set-source-volume @DEFAULT_SOURCE@'
)

hl.bind(main_mod .. "+ XF86AudioRaiseVolume", function()
	hl.dispatch(hl.dsp.exec_cmd("pactl set-source-volume @DEFAULT_SOURCE@ +5%"))
	hl.dispatch(round_source)
end, { submap_universal = true })

hl.bind(main_mod .. "+ XF86AudioLowerVolume", function()
	hl.dispatch(hl.dsp.exec_cmd("pactl set-source-volume @DEFAULT_SOURCE@ -5%"))
	hl.dispatch(round_source)
end, { submap_universal = true })

hl.bind(main_mod .. "+ XF86AudioMute", function()
	hl.dispatch(hl.dsp.exec_cmd("pactl set-source-mute @DEFAULT_SOURCE@ toggle"))
end, { submap_universal = true })

hl.bind(main_mod .. "+ SHIFT + Q", hl.dsp.submap("<D-Q>"))
hl.define_submap("<D-Q>", "reset", function()
	hl.bind("Q", hl.dsp.exit())
	hl.bind("S", hl.dsp.exec_cmd("shutdown -h now"))
	hl.bind("R", hl.dsp.exec_cmd("reboot"))
	hl.bind("L", hl.dsp.exec_cmd("hyprlock"))
	hl.bind("H", hl.dsp.exec_cmd("hyprlock & sleep 1 && systemctl suspend-then-hibernate"))

	hl.bind("catchall", hl.dsp.submap("reset"))
end)

hl.bind(main_mod .. "+ Print", hl.dsp.submap("<Print>"))
hl.define_submap("<Print>", "reset", function()
	hl.bind("Print", hl.dsp.exec_cmd("~/scripts/screenshot screen"))
	hl.bind("W", hl.dsp.exec_cmd("~/scripts/screenshot window"))
	hl.bind("S", function()
		Touchpad:set(true)
		hl.dispatch(hl.dsp.exec_cmd("notify-send 'Touchpad Enabled'"))
		hl.dispatch(hl.dsp.exec_cmd("~/scripts/screenshot select"))
	end)

	hl.bind("catchall", hl.dsp.submap("reset"))
end)
