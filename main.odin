package main

import rl "vendor:raylib"

screen_width :: 1280
screen_height :: 720

Window :: struct {
	name:          cstring,
	width:         i32,
	height:        i32,
	fps:           i32,
	control_flags: rl.ConfigFlags,
}

main :: proc() {


	window := Window {
		"Bush Blazer",
		screen_width,
		screen_height,
		60,
		rl.ConfigFlags{.WINDOW_RESIZABLE},
	}

	rl.InitAudioDevice()

	rl.InitWindow(window.width, window.height, window.name)
	rl.SetWindowMonitor(0)
	rl.DisableCursor()


	for !rl.WindowShouldClose() {


		if (!rl.IsWindowFocused()) {
			rl.SetWindowFocused()
		}

		rl.BeginDrawing()
		rl.ClearBackground(0)
		rl.EndDrawing()
	}

	rl.CloseWindow()
}
