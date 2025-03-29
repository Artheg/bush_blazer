package states

import config "../config"
import "core:c"
import "core:fmt"
import "core:strings"
import rl "vendor:raylib"

INITIAL_COOLDOWN :: 0.21

movement_cooldown := INITIAL_COOLDOWN
move_count := 0

gameplay := GameState {
	pre_render = proc(game_model: ^GameModel) {

		current_time := rl.GetTime()
		if game_model.last_input_time != nil &&
		   current_time - game_model.last_input_time.? < movement_cooldown {
			return
		}
		game_model.last_input_time = current_time
		if (move_count == 1) {
			movement_cooldown = 0.11
		}
		player := &game_model.player
		no_keys_pressed := false
		if rl.IsKeyDown(rl.KeyboardKey.A) || rl.IsKeyDown(rl.KeyboardKey.LEFT) {
			player.col = max(player.col - 1, 0)
		} else if rl.IsKeyDown(rl.KeyboardKey.D) || rl.IsKeyDown(rl.KeyboardKey.RIGHT) {
			player.col = min(player.col + 1, config.col_count - 1)
		} else if rl.IsKeyDown(rl.KeyboardKey.W) || rl.IsKeyDown(rl.KeyboardKey.UP) {
			player.row = max(player.row - 1, 0)
		} else if rl.IsKeyDown(rl.KeyboardKey.S) || rl.IsKeyDown(rl.KeyboardKey.DOWN) {
			player.row = min(player.row + 1, config.row_count - 1)
		} else {
			no_keys_pressed = true
		}

		if (no_keys_pressed) {
			game_model.last_input_time = 0
			move_count = 0
			movement_cooldown = INITIAL_COOLDOWN
		} else {
			move_count += 1
			rl.PlaySound(game_model.sounds.playerMove)
		}

	},
	render = proc(game_model: ^GameModel) {
		for col in game_model.cols {
			for cell in col {
				rl.DrawRectangleLines(
					cell.x - config.cell_size_half,
					cell.y - config.cell_size_half,
					config.cell_size,
					config.cell_size,
					rl.WHITE,
				)
				tree := cell.tree
				if (tree.hp > 0) {
					rl.DrawCircle(cell.x, cell.y, config.cell_size_third, rl.GREEN)
					// rl.DrawCube(rl.Vector3{f32(cell.x), f32(cell.y), 0.0}, 100, 100, 100, rl.WHITE)

				}
			}
		}

		for enemy in game_model.active_enemies {
			if enemy.hp > 0 {
				cell := game_model.cols[enemy.col][enemy.row]
				rl.DrawCircle(cell.x, cell.y, 5, rl.BLUE)
			}
		}

		// draw player
		player := game_model.player
		playerCell := game_model.cols[player.col][player.row]
		rl.DrawCircle(playerCell.x, playerCell.y, 5, rl.RED)
		//


		rl.EndDrawing()
	},
	post_render = proc(game_model: ^GameModel) {},
}
