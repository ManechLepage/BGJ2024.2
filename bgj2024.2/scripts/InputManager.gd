class_name InputManager
extends Node

@onready var tile_layer_manager: TileLayerManager = %TileLayerManager
@onready var finish_turn_button: Button = %FinishTurnButton
@onready var turn_manager: TurnManager = %TurnManager

signal clicked_open_tile
signal finished_turn
signal start_turn
signal start_storm

var finishing_turn: bool = false
var is_storm: bool = false

func _input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("LeftClick"):
		if tile_layer_manager.is_mouse_open_tile():
			clicked_open_tile.emit()

func _on_finish_turn_pressed() -> void:
	if finishing_turn:
		finished_turn.emit()
		if turn_manager.turn % 10 != 0:
			finish_turn_button.text = "Start Turn"
		else:
			finish_turn_button.text = "Start Storm"
			is_storm = true
	else:
		if not is_storm:
			start_turn.emit()
			finish_turn_button.text = "Finish Turn"
			finishing_turn = true
		else:
			start_storm.emit()
			finish_turn_button.text = "Start Turn"
			is_storm = false
