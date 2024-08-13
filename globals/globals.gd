extends Node

var master_sound: int = 100
var music_sound: int = 100
var sound_fx: int = 100
var mute: bool = false

enum ItemType {
	SPEED_INC,
	HEALTH_INC,
	KNOCKBACK_INC,
	
	EXP_SMALL,
}

var player_position: Vector2
