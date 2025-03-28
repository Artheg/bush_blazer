package states

import config "../config"
import "core:c"
import "core:fmt"
import "core:strings"
import rl "vendor:raylib"

cell_size :: 30
startX :: 340
startY :: 200

gameplay := GameState {
	pre_render = proc(game_model: ^GameModel) {},
	render = proc(game_model: ^GameModel) {
		for i := 0; i < config.col_count; i += 1 {
			posX := i32(startX + i * cell_size)
			for j := 0; j < config.row_count; j += 1 {
				posY := i32(startY + j * cell_size)
				rl.DrawRectangleLines(posX, posY, cell_size, cell_size, rl.WHITE)
			}
		}
	},
	post_render = proc(game_model: ^GameModel) {},
}
