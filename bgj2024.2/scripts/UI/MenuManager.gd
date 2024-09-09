class_name MenuManager
extends Node

@onready var tile_layer_manager: TileLayerManager = %TileLayerManager

@onready var main_ui: Control = %MainUI
@onready var main_menu: Control = %MainMenu
@onready var restart_menu: Control = %RestartMenu
@onready var difficulty_menu: Control = %DifficultyMenu
@onready var settings_menu: Control = %SettingsMenu

var is_from_game: bool = false

func focus(menu: Control):
	settings_menu.visible = false
	tile_layer_manager.visible = false
	main_ui.visible = false
	restart_menu.visible = false
	difficulty_menu.visible = false
	main_menu.visible = false
	
	menu.visible = true

func on_death():
	focus(restart_menu)
	tile_layer_manager.visible = true

func _on_main_menu_button_pressed() -> void:
	focus(main_menu)

func _ready() -> void:
	focus(main_menu)

func _on_play_button_pressed() -> void:
	focus(difficulty_menu)

func _on_difficulty_button_pressed() -> void:
	focus(main_ui)
	tile_layer_manager.visible = true

func _on_settings_button_pressed() -> void:
	is_from_game = false
	focus(settings_menu)

func _on_settings_back_button_pressed() -> void:
	if is_from_game:
		focus(main_ui)
		tile_layer_manager.visible = true
	else:
		focus(main_menu)

func _on_game_settings_button_pressed() -> void:
	is_from_game = true
	focus(settings_menu)

func _on_quit_button_pressed() -> void:
	get_tree().quit()
