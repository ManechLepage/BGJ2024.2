class_name Buildings
extends Node

@onready var turn_manager: TurnManager = %TurnManager
@onready var tile_layer_manager: TileLayerManager = %TileLayerManager

@export var buildings: Array[Building]
var total_weight: int

func get_building_from_atlas(atlas: Vector2i):
	for building in buildings:
		if building.sprite_atlas.x == atlas.x:
			var new_building: Building = building.duplicate()
			new_building.current_tier = atlas.y + 1
			return [new_building, new_building.current_tier]
	return [null, null]

func get_building_from_position(position: Vector2i):
	for building in tile_layer_manager.get_all_buildings():
		if building.position == position:
			return building
	return null

func get_random_building():
	total_weight = 0
	for building in filtered_buildings():
		total_weight += building.rarity
	
	var random_weight: int = randi_range(0, total_weight)
	for building in filtered_buildings():
		if random_weight < building.rarity:
			var random_tier = randi_range(0, 10)
			if random_tier == 1:
				building.current_tier = 2
			else:
				building.current_tier = 1
			return building
		random_weight -= building.rarity
	return null

func filtered_buildings():
	var filtered: Array[Building]
	for building in buildings:
		if building.start_apperance < turn_manager.turn:
			filtered.append(building)
	return filtered
