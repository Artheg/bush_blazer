package states

import rl "vendor:raylib"

col_count :: 10
row_count :: 10
max_enemies :: 256

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
	active_enemies:     [max_enemies]Enemy,
	require_next_state: proc(status: GameStatus),
	cells:              [col_count * row_count]Cell,
}

Enemy :: struct {
	value:    cstring,
	position: rl.Vector2,
	is_alive: bool,
	damage:   u8,
	speed:    f32,
}

Cell :: struct {
	x: int,
	y: int,
}
