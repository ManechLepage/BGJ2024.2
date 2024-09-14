class_name SoundManager
extends Node

@onready var button_click: AudioStreamPlayer = $ButtonClick
@onready var button_hover: AudioStreamPlayer = $ButtonHover
@onready var coin: AudioStreamPlayer = $Coin
@onready var place_building: AudioStreamPlayer = $PlaceBuilding
@onready var merge_building: AudioStreamPlayer = $MergeBuilding
@onready var main_menu_music: AudioStreamPlayer = $MainMenuMusic
@onready var game_music: AudioStreamPlayer = $GameMusic
@onready var game_atmosphere: AudioStreamPlayer = $GameAtmosphere

func play_click():
	button_click.play()

func play_hover():
	button_hover.play()

func play_coin():
	coin.play()

func play_place_building():
	merge_building.play()

func play_merge_building():
	merge_building.play()

func play_game_music():
	main_menu_music.stop()
	game_music.play()
	game_atmosphere.play()

func play_menu_music():
	main_menu_music.play()
	game_music.stop()
	game_atmosphere.stop()

func _on_main_menu_music_finished() -> void:
	main_menu_music.play()

func _on_game_music_finished() -> void:
	game_music.play()

func _on_game_atmosphere_finished() -> void:
	game_atmosphere.play()

func _on_master_slider_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_db(0, value)

func _on_music_slider_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_db(2, value)

func _on_sfx_slider_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_db(1, value)

func _on_main_menu_button_pressed() -> void:
	pass # Replace with function body.
