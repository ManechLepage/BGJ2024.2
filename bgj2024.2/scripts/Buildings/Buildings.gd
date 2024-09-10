class_name Buildings
extends Node

@export var buildings: Array[Building]

func get_building_from_atlas(atlas: Vector2i):
	for building in buildings:
		if building.sprite_atlas.x == atlas.x:
			building.current_tier = atlas.y + 1
			return [building, building.current_tier]
	return null

func get_building_from_position(position: Vector2i):
	for building in buildings:
		print(building.position)
		if building.position == position:
			return building
	return null
