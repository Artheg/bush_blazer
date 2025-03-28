package states

import "core:c"
import "core:fmt"
import "core:strings"
import rl "vendor:raylib"

gameplay := GameState {
	pre_render = proc(game_model: ^GameModel) {},
	render = proc(game_model: ^GameModel) {},
	post_render = proc(game_model: ^GameModel) {},
}
