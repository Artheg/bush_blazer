package states

import config "../config"
import rl "vendor:raylib"

main_menu := GameState {
	pre_render = proc(game_model: ^GameModel) {},
	render = proc(game_model: ^GameModel) {
		rl.DrawText("Bush Blazer", config.screen_width / 2, config.screen_height / 2, 20, rl.WHITE)
		rl.DrawText(
			"Kill all hippies and burn the forest down",
			config.screen_width / 2,
			config.screen_height / 2 + 20,
			10,
			rl.WHITE,
		)
		rl.DrawText(
			"(Press SPACE to play)",
			config.screen_width / 2,
			config.screen_height / 2 + 60,
			10,
			rl.WHITE,
		)

	},
	post_render = proc(game_model: ^GameModel) {
		if (rl.IsKeyPressed(rl.KeyboardKey.SPACE)) {
			game_model.require_next_state(GameStatus.PLAYING)
		}
	},
}
