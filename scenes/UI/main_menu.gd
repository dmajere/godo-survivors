extends Control

@onready var master_sound_slide = $Options/HBoxContainer/OptionsMenu/AudioOptions/HBoxContainer/Toggle/Master
@onready var music_sound_slide = $Options/HBoxContainer/OptionsMenu/AudioOptions/HBoxContainer/Toggle/Music
@onready var sound_fx_slide = $Options/HBoxContainer/OptionsMenu/AudioOptions/HBoxContainer/Toggle/SoundFx
@onready var mute_toggle = $Options/HBoxContainer/OptionsMenu/AudioOptions/HBoxContainer/Toggle/Mute

func _ready():
	master_sound_slide.value = Globals.master_sound
	music_sound_slide.value = Globals.music_sound
	sound_fx_slide.value = Globals.sound_fx
	mute_toggle.button_pressed = Globals.mute


func _on_mute_pressed():
	Globals.mute = mute_toggle.button_pressed

func _on_sound_fx_drag_ended(value_changed):
	if value_changed:
		Globals.sound_fx = sound_fx_slide.value

func _on_music_drag_ended(value_changed):
	if value_changed:
		Globals.music_sound = music_sound_slide.value

func _on_master_drag_ended(value_changed):
	if value_changed:
		Globals.master_sound = master_sound_slide.value

func _on_options_back_pressed():
	$Options.visible = false
	$Main.visible = true

func _on_options_pressed():
	$Main.visible = false
	$Options.visible = true
	
func _on_exit_pressed():
	get_tree().quit()

func _on_start_pressed():
	#TODO:
	# * Character and level selection menu
	$GameStartTransition.change_scene("res://scenes/levels/level.tscn")
