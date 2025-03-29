package main

import config "./config"
import states "./states"
import "core:fmt"
import "core:math/rand"
import rl "vendor:raylib"

Window :: struct {
	name:          cstring,
	width:         i32,
	height:        i32,
	fps:           i32,
	control_flags: rl.ConfigFlags,
}

current_state := states.main_menu
current_music: Maybe(rl.Music)

main :: proc() {


	window := Window {
		"Bush Blazer",
		config.screen_width,
		config.screen_height,
		60,
		rl.ConfigFlags{.WINDOW_RESIZABLE, .WINDOW_TRANSPARENT},
	}

	rl.InitAudioDevice()

	rl.InitWindow(window.width, window.height, window.name)
	rl.SetWindowMonitor(0)
	rl.SetTargetFPS(window.fps)
	// rl.DisableCursor()

	game_model := create_model()

	time_spent := 0.0
	for !rl.WindowShouldClose() {

		// if (rl.GetTime() - time_spent > 1) {
		// 	game_model = create_model()
		// 	fmt.println(len(game_model.cols))
		// 	time_spent = rl.GetTime()
		// }

		if (current_music != nil) {
			rl.UpdateMusicStream(current_music.?)
		}

		// if (!rl.IsWindowFocused()) {
		// 	rl.SetWindowFocused()
		// }

		current_state.pre_render(&game_model)

		rl.ClearBackground(26)
		rl.BeginDrawing()
		current_state.render(&game_model)
		rl.EndDrawing()

		current_state.post_render(&game_model)

	}

	rl.CloseWindow()
}

create_model :: proc() -> states.GameModel {
	game_model := states.GameModel {
		// TODO: move to resources
		sounds = states.Sound{playerMove = rl.LoadSound("./resources/player_move.wav")},
		//
		status = states.GameStatus.MENU,
		require_next_state = proc(status: states.GameStatus) {
			switch (status) {
			case states.GameStatus.MENU:
				current_state = states.main_menu
			case states.GameStatus.PLAYING:
				current_state = states.gameplay
				current_music = rl.LoadMusicStream("./resources/music.mp3")
				rl.PlayMusicStream(current_music.?)
			case states.GameStatus.GAME_OVER:
				current_state = states.game_over
			}
		},
		player = states.Player {
			hp = 100,
			col = rand.int_max(config.col_count),
			row = rand.int_max(config.row_count),
		},
	}

	cell_index := 0
	for i := 0; i < config.col_count; i += 1 {
		posX := i32(config.startX + i * config.cell_size)
		for j := 0; j < config.row_count; j += 1 {
			posY := i32(config.startY + j * config.cell_size)
			game_model.cols[i][j] = states.Cell {
				x = posX + config.cell_size * 0.5,
				y = posY + config.cell_size * 0.5,
				col = i,
				row = j,
				tree = states.Tree {
					hp = rand.int_max(100) > 50 ? 100 : 0,
					status = states.TreeStatus.IDLE,
				},
			}
			cell_index += 1
		}
	}
	return game_model
	//
}
