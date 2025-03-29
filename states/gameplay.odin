package states

import config "../config"
import "core:c"
import "core:fmt"
import "core:strings"
import rl "vendor:raylib"


gameplay := GameState {
	pre_render = proc(game_model: ^GameModel) {
		player := &game_model.player
		#partial switch (rl.GetKeyPressed()) {
		case rl.KeyboardKey.LEFT:
			player.col = max(player.col - 1, 0)
			break
		case rl.KeyboardKey.RIGHT:
			player.col = min(player.col + 1, config.col_count - 1)
			break
		case rl.KeyboardKey.UP:
			player.row = max(player.row - 1, 0)
			break
		case rl.KeyboardKey.DOWN:
			player.row = min(player.row + 1, config.row_count - 1)
			break
		}
	},
	render = proc(game_model: ^GameModel) {
		for col in game_model.cols {
			for cell in col {
				rl.DrawRectangleLines(cell.x, cell.y, config.cell_size, config.cell_size, rl.WHITE)
			}
		}

		player := game_model.player
		playerCell := game_model.cols[player.col][player.row]
		rl.DrawCircle(
			playerCell.x + config.cell_size * 0.5,
			playerCell.y + config.cell_size * 0.5,
			5,
			rl.RED,
		)


	},
	post_render = proc(game_model: ^GameModel) {},
}
