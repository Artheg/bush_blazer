package states

import config "../config"
import rl "vendor:raylib"

GameState :: struct {
	on_enter:    proc(),
	on_exit:     proc(),
	pre_render:  proc(game_model: ^GameModel),
	render:      proc(game_model: ^GameModel),
	post_render: proc(game_model: ^GameModel),
}

GameStatus :: enum {
	PLAYING,
	GAME_OVER,
	MENU,
}

GameModel :: struct {
	hp:                 i32,
	status:             GameStatus,
	active_enemies:     [config.max_enemies]Enemy,
	require_next_state: proc(status: GameStatus),
	cells:              [config.col_count * config.row_count]Cell,
}

Enemy :: struct {
	value:    cstring,
	position: rl.Vector2,
	is_alive: bool,
	damage:   u8,
	speed:    f32,
}

TreeStatus :: enum {
	IDLE,
	BURNING,
	DEAD,
}

Tree :: struct {
	hp:     int,
	status: TreeStatus,
}

Cell :: struct {
	x:    int,
	y:    int,
	tree: Maybe(^Tree),
}
