class_name ScoreCalculator
extends Node

@onready var tile_layer_manager: TileLayerManager = %TileLayerManager
@onready var building_effects: BuildingEffects = %BuildingEffects

signal finished_calculating(total: Array)
signal finished_calculating_storm(total: Array)

func calculate():
	var buildings: Array[Building] = tile_layer_manager.get_all_buildings().duplicate(true)
	
	for building in buildings:
		building_effects.activate_building(building, buildings)
	
	var turn_revenue: int = 0
	var turn_electricity: int = 0
	var turn_water: int = 0
	
	for building in buildings:
		turn_revenue += building.money
		turn_electricity += building.electricity
		turn_water += building.water
	
	var current_total :Array = [turn_revenue, turn_electricity, turn_water]
	
	for building in buildings:
		current_total = building_effects.activate_building_total_buff(building, current_total[0], current_total[1], current_total[2])
	
	finished_calculating.emit(current_total)

func _on_finished_turn() -> void:
	calculate()

func _on_start_storm() -> void:
	print("---")
	var buildings: Array[Building] = tile_layer_manager.get_all_buildings().duplicate(true)
	
	var total: Array = [0, 0]
	for building in buildings:
		total = building_effects.activate_building_storm(building, total[0], total[1])
	
	finished_calculating_storm.emit(total)
