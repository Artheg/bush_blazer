package states

import config "../config"
import rl "vendor:raylib"

game_over := GameState {
	on_enter = proc() {},
	pre_render = proc(game_model: ^GameModel) {},
	render = proc(game_model: ^GameModel) {},
	post_render = proc(game_model: ^GameModel) {},
}
