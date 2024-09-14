class_name BuildingEffect
extends Node

@export var building_name: String
var parent: BuildingEffects

func _ready() -> void:
	parent = get_parent()

func activate(building: Building, buildings: Array[Building]):
	pass

func activate_total_buff(building: Building, buildings: Array[Building], revenue: int, electricity: int, water: int):
	return [revenue, electricity, water]

func activate_storm(building: Building, buildings: Array[Building], electricity: int, water: int):
	return [electricity, water]
