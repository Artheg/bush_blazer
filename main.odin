package main

import config "./config"
import states "./states"
import rl "vendor:raylib"

Window :: struct {
	name:          cstring,
	width:         i32,
	height:        i32,
	fps:           i32,
	control_flags: rl.ConfigFlags,
}

current_state := states.main_menu

main :: proc() {


	window := Window {
		"Bush Blazer",
		config.screen_width,
		config.screen_height,
		60,
		rl.ConfigFlags{.WINDOW_RESIZABLE},
	}

	rl.InitAudioDevice()

	rl.InitWindow(window.width, window.height, window.name)
	rl.SetWindowMonitor(0)
	rl.SetTargetFPS(60)
	// rl.DisableCursor()


	game_model := states.GameModel {
		// TODO: move to resources
		sounds = states.Sound{playerMove = rl.LoadSound("./resources/player_move.wav")},
		status = states.GameStatus.MENU,
		require_next_state = proc(status: states.GameStatus) {
			switch (status) {
			case states.GameStatus.MENU:
				current_state = states.main_menu
			case states.GameStatus.PLAYING:
				current_state = states.gameplay
			case states.GameStatus.GAME_OVER:
				current_state = states.game_over
			}
		},
		player = states.Player{hp = 100},
	}

	cell_index := 0
	for i := 0; i < config.col_count; i += 1 {
		posX := i32(config.startX + i * config.cell_size)
		for j := 0; j < config.row_count; j += 1 {
			posY := i32(config.startY + j * config.cell_size)
			game_model.cols[i][j] = states.Cell {
				x   = posX,
				y   = posY,
				col = i,
				row = j,
			}
			cell_index += 1
		}
	}

	for !rl.WindowShouldClose() {


		// if (!rl.IsWindowFocused()) {
		// 	rl.SetWindowFocused()
		// }

		current_state.pre_render(&game_model)

		rl.BeginDrawing()
		current_state.render(&game_model)
		rl.ClearBackground(0)
		rl.EndDrawing()

		current_state.post_render(&game_model)

	}

	rl.CloseWindow()
}
