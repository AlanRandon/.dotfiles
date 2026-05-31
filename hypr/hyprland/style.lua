local colors = require("themes.catppuccin-frappe")

hl.monitor({
	output = "eDP-1",
	mode = "2880x1800@60.00",
	position = "0x0",
	scale = 2.25,
})

hl.config({
	general = {
		border_size = 4,
		["col.active_border"] = { colors = { colors.green, colors.teal } },
		["col.inactive_border"] = colors.base,
		gaps_in = 2,
		gaps_out = 4,
		resize_on_border = true,
		allow_tearing = false,
	},
	misc = {
		force_default_wallpaper = 0,
		disable_hyprland_logo = true,
	},
	xwayland = {
		force_zero_scaling = true,
	},
	decoration = {
		shadow = { enabled = false },
	},
})

hl.curve("menu_decel", { type = "bezier", points = { { 0.1, 1 }, { 0, 1 } } })
hl.curve("menu_accel", { type = "bezier", points = { { 0.38, 0.04 }, { 1, 0.07 } } })
hl.curve("md3_decel", { type = "bezier", points = { { 0.05, 0.7 }, { 0.1, 1 } } })

hl.animation({ leaf = "border", enabled = false })
hl.animation({ leaf = "fade", enabled = false })
hl.animation({ leaf = "workspaces", enabled = false })
hl.animation({ leaf = "specialWorkspace", enabled = false })
hl.animation({ leaf = "windows", speed = 0.5, bezier = "md3_decel", enabled = true, style = "popin" })
hl.animation({ leaf = "layersIn", speed = 3, bezier = "menu_decel", enabled = true, style = "slide" })
hl.animation({ leaf = "fadeLayersIn", speed = 1.6, bezier = "menu_decel", enabled = true })
hl.animation({ leaf = "layersOut", speed = 1, bezier = "menu_accel", enabled = true })
hl.animation({ leaf = "fadeLayersOut", speed = 0.5, bezier = "menu_accel", enabled = true })

hl.workspace_rule({ workspace = "1", on_created_empty = "[float; size 800 500] ~/scripts/motd" })

hl.workspace_rule({ workspace = "w[tv1]", gaps_out = 0, gaps_in = 0 })
hl.window_rule({ match = { float = false, workspace = "w[tv1]" }, border_size = 2, border_color = colors.base })
hl.window_rule({ match = { float = false, workspace = "w[tv1]" }, rounding = 0 })

hl.workspace_rule({ workspace = "f[1]", gaps_out = 0, gaps_in = 0 })
hl.window_rule({ match = { float = false, workspace = "f[1]" }, border_size = 0 })
hl.window_rule({ match = { float = false, workspace = "f[1]" }, rounding = 0 })

hl.layer_rule({
	name = "no-anim-for-selection",
	match = { namespace = "selection" },
	no_anim = true,
})

hl.window_rule({
	name = "fullscreen-waydroid",
	match = { class = ".*[wW]aydroid.*" },
	fullscreen = true,
})

hl.window_rule({
	name = "suppress-maximise",
	match = { class = ".*" },
	suppress_event = "maximize",
})

hl.window_rule({
	name = "floating-small-borders",
	match = { float = true },
	rounding = 10,
	border_size = 1,
	border_color = colors.overlay0,
})

local PictureInPicture = require("hyprland.PictureInPicture")
PictureInPicture:update()
