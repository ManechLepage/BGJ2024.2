class_name PlacementManager
extends Node

@export var test_building: Building
var current_selected_building: Building

@onready var tile_layer_manager: TileLayerManager = %TileLayerManager

func _ready() -> void:
	#current_selected_building = test_building
	pass

func _process(delta: float) -> void:
	if current_selected_building:
		tile_layer_manager.place_preview_at_mouse_position(current_selected_building)

func _on_clicked_open_tile() -> void:
	if current_selected_building:
		tile_layer_manager.place_building_at_mouse_position(current_selected_building)
		current_selected_building = null

func _on_input_manager_clicked_merging_tile() -> void:
	if current_selected_building:
		tile_layer_manager.merge_building_at_mouse_position(current_selected_building)
		current_selected_building = null
