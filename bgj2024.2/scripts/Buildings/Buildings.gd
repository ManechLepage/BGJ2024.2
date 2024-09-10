class_name Buildings
extends Node

@export var buildings: Array[Building]
var total_weight: int

func _ready() -> void:
	for building in buildings:
		total_weight += building.rarity

func get_building_from_atlas(atlas: Vector2i):
	for building in buildings:
		if building.sprite_atlas.x == atlas.x:
			var new_building: Building = building.duplicate()
			new_building.current_tier = atlas.y + 1
			return [new_building, new_building.current_tier]
	return [null, null]

func get_building_from_position(position: Vector2i):
	for building in buildings:
		print(building.position)
		if building.position == position:
			return building
	return null

func get_random_building():
	var random_weight: int = randi_range(0, total_weight)
	for building in buildings:
		if random_weight < building.rarity:
			var random_tier = randi_range(0, 5)
			if random_tier == 5:
				building.current_tier = 2
			return building
		random_weight -= building.rarity
