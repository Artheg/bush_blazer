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


Sound :: struct {
	playerMove: rl.Sound,
}

Music :: struct {
	gameplay: rl.Music,
}

GameModel :: struct {
	status:             GameStatus,
	active_enemies:     [config.max_enemies]Enemy,
	require_next_state: proc(status: GameStatus),
	cols:               [config.col_count][config.row_count]Cell,
	player:             Player,
	sounds:             Sound,
	music:              Music,
	last_input_time:    Maybe(f64),
}

Position :: struct {
	row: int,
	col: int,
}

Direction :: enum {
	LEFT,
	RIGHT,
	UP,
	DOWN,
}

Enemy :: struct {
	col:    int,
	row:    int,
	hp:     int,
	damage: u8,
}

PlayerState :: enum {}

Player :: struct {
	hp:  int,
	col: int,
	row: int,
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
	x:      i32,
	y:      i32,
	col:    int,
	row:    int,
	tree:   Tree,
	enemy:  Maybe(^Enemy),
	player: Maybe(^Player),
}
