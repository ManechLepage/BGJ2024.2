class_name Buildings
extends Node

@export var buildings: Array[Building]

func get_building_from_atlas(atlas: Vector2i):
	for building in buildings:
		if building.sprite_atlas == atlas:
			return building
	return null

func get_building_from_position(position: Vector2i):
	for building in buildings:
		if building.position == position:
			return building
	return null
