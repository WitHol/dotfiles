-- General
hl.bind("SUPER + RETURN", hl.dsp.exec_cmd("applauncher"))
hl.bind("SUPER + SPACE", hl.dsp.exec_cmd("alacritty"))
hl.bind("SUPER + E", hl.dsp.exec_cmd("alacritty -e lf"))
hl.bind("SUPER + period", hl.dsp.exec_cmd("emojimenu"))
hl.bind("SUPER + Q", hl.dsp.window.close({}))
hl.bind("SUPER + P", hl.dsp.exec_cmd("powermenu"))
hl.bind("SUPER + S", hl.dsp.exec_cmd("screenshot"))
hl.bind("SUPER + N", hl.dsp.exec_cmd("networkmenu"))
hl.bind("SUPER + C", hl.dsp.exec_cmd("keyboard-layout-menu"))
hl.bind("SUPER + ALT + C", hl.dsp.exec_cmd("keyboard-layout-menu"))
hl.bind("SUPER + R", hl.dsp.exec_cmd("refresh"))
hl.bind("SUPER + F", hl.dsp.window.fullscreen())

-- Navigation
hl.bind("SUPER + H", hl.dsp.focus({ direction = "left" }))
hl.bind("SUPER + J", hl.dsp.focus({ direction = "down" }))
hl.bind("SUPER + K", hl.dsp.focus({ direction = "up" }))
hl.bind("SUPER + L", hl.dsp.focus({ direction = "right" }))
hl.bind("SUPER + U", hl.dsp.focus({ workspace = "-1" }))
hl.bind("SUPER + I", hl.dsp.focus({ workspace = "+1" }))

-- Windows
hl.bind("SUPER + ALT + H", hl.dsp.window.move({ direction = "left" }))
hl.bind("SUPER + ALT + J", hl.dsp.window.move({ direction = "down" }))
hl.bind("SUPER + ALT + K", hl.dsp.window.move({ direction = "up" }))
hl.bind("SUPER + ALT + L", hl.dsp.window.move({ direction = "right" }))
hl.bind("SUPER + ALT + U", hl.dsp.window.move({ workspace = "-1" }))
hl.bind("SUPER + ALT + I", hl.dsp.window.move({ workspace = "+1" }))
hl.bind("SUPER + mouse:272", hl.dsp.window.drag())

-- Resizing windows
hl.bind("SUPER + SHIFT + H", hl.dsp.window.resize({ x = -200, y = 0, relative = true }))
hl.bind("SUPER + SHIFT + J", hl.dsp.window.resize({ x = 0, y = 100, relative = true }))
hl.bind("SUPER + SHIFT + K", hl.dsp.window.resize({ x = 0, y = -100, relative = true }))
hl.bind("SUPER + SHIFT + L", hl.dsp.window.resize({ x = 200, y = 0, relative = true }))
hl.bind("SUPER + mouse:273", hl.dsp.window.resize())

-- Floating windows
hl.bind("SUPER + V", hl.dsp.window.float())
-- TODO: Add centering a floating window
-- TODO: Add a keybind to cycle between floating windows
