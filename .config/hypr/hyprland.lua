hl.monitor({
	output = "HDMI-A-1",
	mode = "2560x1440@120",
	position = "auto",
	scale = 1,
	bitdepth = 10,
})

hl.monitor({
	output = "eDP-1",
	disabled = true,
	position = "auto",
	scale = 1,
})

hl.env("XCURSOR_SIZE", "24")
hl.env("XCURSOR_THEME", "Sweet-cursors")
hl.env("HYPRCURSOR_SIZE", "24")

hl.config({
	ecosystem = {
		no_update_news = true,
		no_donation_nag = true,
		enforce_permissions = true,
	},

	quirks = {
		prefer_hdr = 1,
	},

	render = {
		cm_auto_hdr = 2,
		direct_scanout = 1,
	},

	general = {
		gaps_in = 2,
		gaps_out = 2,
		border_size = 0,
		resize_on_border = false,
		allow_tearing = false,
		layout = "dwindle",
	},

	decoration = {
		rounding = 5,
		rounding_power = 10,
		active_opacity = 1.0,
		inactive_opacity = 0.95,
		dim_inactive = true,
		dim_strength = 0.07,

		shadow = {
			enabled = true,
			range = 5,
			render_power = 5,
			color = 0x10101055,
		},

		blur = {
			enabled = true,
			ignore_opacity = false,
			size = 2,
			passes = 4,
			noise = 0.01,
			contrast = 1.0,
			brightness = 1.0,

			vibrancy = 0.2,
			vibrancy_darkness = 0.5,

			popups = true,
		},
	},

	misc = {
		force_default_wallpaper = 0,
		disable_hyprland_logo = true,
		animate_manual_resizes = true,
		animate_mouse_windowdragging = true,
		session_lock_xray = true,
		focus_on_activate = true,
		font_family = "JetBrains Mono, 20pt",
	},

	input = {
		kb_layout = "us,ru",
		kb_options = "compose:ralt,grp:caps_toggle",
		kb_rules = "evdev",

		repeat_delay = 300,
		repeat_rate = 50,

		follow_mouse = 1,

		sensitivity = 0,

		touchpad = {
			natural_scroll = false,
		},
	},

	gestures = {
		workspace_swipe_touch = true,
	},

	animations = {
		enabled = true,
		workspace_wraparound = true,
	},
})

hl.permission("/usr/bin/grim", "screencopy", "allow")
hl.permission("/usr/lib/xdg-desktop-portal-hyprland", "screencopy", "allow")

for _, curve in pairs({
	{ "easeOutQuint", { { 0.23, 1 }, { 0.32, 1 } } },
	{ "easeInOutCubic", { { 0.65, 0.05 }, { 0.36, 1 } } },
	{ "linear", { { 0, 0 }, { 1, 1 } } },
	{ "almostLinear", { { 0.5, 0.5 }, { 0.75, 1 } } },
	{ "quick", { { 0.15, 0 }, { 0.1, 1 } } },
}) do
	local name, points = table.unpack(curve)
	hl.curve(name, { type = "bezier", points = points })
end

for _, animation in pairs({
	{ "global", 10, "default" },
	{ "border", 5.39, "easeOutQuint" },
	{ "windows", 4.79, "easeOutQuint" },
	{ "windowsIn", 4.1, "easeOutQuint", "popin 87%" },
	{ "windowsOut", 1.49, "linear", "popin 87%" },
	{ "windowsMove", 2.5, "easeOutQuint" },
	{ "fadeIn", 1.73, "almostLinear" },
	{ "fadeOut", 1.46, "almostLinear" },
	{ "fade", 3.03, "quick" },
	{ "layers", 3.81, "easeOutQuint" },
	{ "layersIn", 4, "easeOutQuint", "fade" },
	{ "layersOut", 1.5, "linear", "fade" },
	{ "fadeLayersIn", 1.79, "almostLinear" },
	{ "fadeLayersOut", 1.39, "almostLinear" },
	{ "workspaces", 1.94, "almostLinear", "slide" },
	{ "workspacesIn", 2.5, "almostLinear", "fade" },
	{ "workspacesOut", 2.5, "almostLinear", "fade" },
	{ "zoomFactor", 7, "quick" },
}) do
	local leaf, speed, bezier, style = table.unpack(animation)
	hl.animation({ leaf = leaf, enabled = true, speed = speed, bezier = bezier, style = style })
end

hl.gesture({
	fingers = 4,
	direction = "horizontal",
	action = "workspace",
})

hl.on("hyprland.start", function()
	for _, command in pairs({
		"systemctl --user start hyprland-session.target",
		"albert",
		"copyq --start-server",
		"kdeconnectd",
		"swaybg --image /usr/share/wallpapers/MilkyWay/contents/images/5120x2880.png",
	}) do
		hl.exec_cmd(command)
	end
end)

function mod(key)
	return "SUPER + " .. key
end

for _, bind in pairs({
	{ "Return", "kitty" },
	{ "E", "nautilus" },
	{ "SUPER_L", "albert toggle" },
	{ "SHIFT + L", "hyprlock" },
	{ "A", "pavucontrol" },
	{ "B", "blueman-manager" },
}) do
	local key, command = table.unpack(bind)
	hl.bind(mod(key), hl.dsp.exec_cmd(command), { release = true })
end

hl.bind(mod("mouse:274"), hl.dsp.window.close(), { click = true })
hl.bind(mod("Q"), hl.dsp.window.close(), { release = true })
hl.bind(mod("F"), hl.dsp.window.fullscreen(), { release = true })
hl.bind(mod("V"), hl.dsp.window.float(), { release = true })
hl.bind(mod("Z"), hl.dsp.layout("togglesplit"))

function screenshot(command_pattern)
	return function()
		local filepath = os.date("~/Pictures/screenshot_%Y-%m-%d-%H%M%S.png")
		local command = string.gsub(command_pattern, "%%f", filepath)
		hl.exec_cmd(command)
		hl.notification.create({ text = command, timeout = 10000, icon = "info" })
	end
end

hl.bind("Print", screenshot("grim -c %f && wl-copy < %f"))
hl.bind("SHIFT + Print", screenshot('grim -c -g "$(slurp)" %f && wl-copy < %f'))

hl.bind("CONTROL + ALT + Backspace", hl.dsp.exit())

for _, movebind in pairs({
	{ "left", "H", "l" },
	{ "right", "L", "r" },
	{ "up", "K", "u" },
	{ "down", "J", "d" },
}) do
	local arrow_key, vim_key, direction = table.unpack(movebind)
	local focus_dsp = hl.dsp.focus({ direction = direction })
	hl.bind(mod(arrow_key), focus_dsp)
	hl.bind(mod(vim_key), focus_dsp)
end

for i = 1, 9 do
	hl.bind(mod(i), hl.dsp.focus({ workspace = i }))
	hl.bind(mod("SHIFT + " .. i), hl.dsp.window.move({ workspace = i }))
end

hl.bind(mod("mouse:272"), hl.dsp.window.drag(), { mouse = true })
hl.bind(mod("mouse:273"), hl.dsp.window.resize(), { mouse = true })

for _, locked_bind in pairs({
	{ "XF86AudioRaiseVolume", "wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+", true },
	{ "XF86AudioLowerVolume", "wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-", true },
	{ "XF86AudioMute", "wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle", true },
	{ "XF86AudioMicMute", "wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle", true },
	{ "XF86MonBrightnessUp", "brightnessctl -e4 -n2 set 5%+", true },
	{ "XF86MonBrightnessDown", "brightnessctl -e4 -n2 set 5%-", true },

	{ "XF86AudioNext", "playerctl next" },
	{ "XF86AudioPause", "playerctl play-pause" },
	{ "XF86AudioPlay", "playerctl play-pause" },
	{ "XF86AudioPrev", "playerctl previous" },
}) do
	local key, command, repeating = table.unpack(locked_bind)
	hl.bind(key, hl.dsp.exec_cmd(command), { locked = true, repeating = repeating })
end

for _, appname in pairs({ "albert", "blueman-manager", "pavucontrol" }) do
	hl.window_rule({
		match = { class = appname },
		float = true,
	})
end

hl.layer_rule({
	match = { class = "slurp" },
	blur = false,
})

-- Smart gaps (from the wiki)
hl.workspace_rule({ workspace = "w[tv1]", gaps_out = 0, gaps_in = 0 })
hl.workspace_rule({ workspace = "f[1]", gaps_out = 0, gaps_in = 0 })
hl.window_rule({ match = { float = false, workspace = "w[tv1]" }, border_size = 0 })
hl.window_rule({ match = { float = false, workspace = "w[tv1]" }, rounding = 0 })
hl.window_rule({ match = { float = false, workspace = "f[1]" }, border_size = 0 })
hl.window_rule({ match = { float = false, workspace = "f[1]" }, rounding = 0 })
