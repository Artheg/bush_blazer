package sound

import rl "vendor:raylib"

SFX :: struct {
	player_move: rl.Sound,
}

player_move := rl.LoadSound("../resources/player_move.wav")
