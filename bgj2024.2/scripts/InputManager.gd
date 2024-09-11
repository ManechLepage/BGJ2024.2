class_name InputManager
extends Node

@onready var tile_layer_manager: TileLayerManager = %TileLayerManager
@onready var finish_turn_button: Button = %FinishTurnButton
@onready var turn_manager: TurnManager = %TurnManager
@onready var placement_manager: PlacementManager = %PlacementManager
@onready var timer: Timer = $Timer
@onready var building_info: Control = %BuildingInfo
@onready var buildings: Buildings = %Buildings

signal clicked_open_tile
signal clicked_merging_tile

signal finished_turn
signal start_turn
signal start_storm

signal show_card

var finishing_turn: bool = false
var is_storm: bool = false

var last_grid_mouse_position: Vector2i

@export var offset: Vector2

func _process(delta: float) -> void:
	var current_grid_mouse_position: Vector2i = tile_layer_manager.get_building_mouse_position()
	if current_grid_mouse_position != last_grid_mouse_position:
		building_info.visible = false
		last_grid_mouse_position = current_grid_mouse_position
		timer.time_left
		timer.start()

func _input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("LeftClick"):
		if tile_layer_manager.is_mouse_open_tile():
			clicked_open_tile.emit()
		if placement_manager.current_selected_building:
			if tile_layer_manager.can_merge_at_mouse_position(placement_manager.current_selected_building):
				clicked_merging_tile.emit()

func _on_finish_turn_pressed() -> void:
	if finishing_turn:
		finished_turn.emit()
		if turn_manager.turn % 10 != 0:
			finish_turn_button.text = "Start Turn"
		else:
			finish_turn_button.text = "Start Storm"
			is_storm = true
		finish_turn_button.disabled = true
	else:
		if not is_storm:
			start_turn.emit()
			finish_turn_button.text = "Finish Turn"
			finishing_turn = true
		else:
			start_storm.emit()
			finish_turn_button.text = "Start Turn"
			is_storm = false

func _on_score_calculator_finished_calculating(total: Array) -> void:
	finish_turn_button.disabled = false

func _on_score_calculator_finished_calculating_storm(total: Array) -> void:
	finish_turn_button.disabled = false

func _on_timer_timeout() -> void:
	if not tile_layer_manager.is_mouse_open_tile():
		var building: Building = buildings.get_building_from_position(tile_layer_manager.get_building_mouse_position())
		if building:
			building_info.load_building(building)
			building_info.visible = true
			building_info.position = tile_layer_manager.get_local_mouse_position() + offset
