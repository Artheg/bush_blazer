package states

import config "../config"
import "core:c"
import "core:fmt"
import "core:strings"
import rl "vendor:raylib"


gameplay := GameState {
	pre_render = proc(game_model: ^GameModel) {},
	render = proc(game_model: ^GameModel) {
		cells := game_model.cells
		for cell in cells {
			rl.DrawRectangleLines(cell.x, cell.y, config.cell_size, config.cell_size, rl.WHITE)
		}
	},
	post_render = proc(game_model: ^GameModel) {},
}
