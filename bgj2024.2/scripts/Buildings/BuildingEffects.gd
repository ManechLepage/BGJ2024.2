class_name BuildingEffects
extends Node

@onready var tile_layer_manager: TileLayerManager = %TileLayerManager
@onready var building_data: Buildings = %Buildings

func activate_building(building: Building, buildings: Array[Building]):
	for child in get_children():
		if child.building_name == building.name:
			child.activate(building, buildings)

func activate_building_total_buff(building: Building, revenue: int, electricity: int, water: int):
	var current_total: Array = [revenue, electricity, water]
	for child in get_children():
		if child.building_name == building.name:
			current_total = child.activate_total_buff(building, revenue, electricity, water)
	return current_total

func activate_building_storm(building: Building, electricity: int, water: int):
	var current_total: Array = [electricity, water]
	for child in get_children():
		if child.building_name == building.name:
			current_total = child.activate_storm(building, current_total[0], current_total[1])
	return current_total

func get_surrounding_buildings(building: Building, buildings: Array[Building]):
	var positions = tile_layer_manager.get_neighbouring_positions(building.position)
	var updated_positions: Array[Vector2i]
	for position in positions:
		updated_positions.append(position + building.position)
	var surrounding_buildings: Array[Building]
	for target_building in buildings:
		if target_building.position in updated_positions:
			surrounding_buildings.append(target_building)
	return surrounding_buildings

func filter_buildings(target_building: Building, buildings: Array[Building]):
	var target_buildings: Array[Building]
	
	for building in buildings:
		if target_building.name == building.name:
			target_buildings.append(building)
	
	return target_buildings

func filter_buildings_by_type(type: Building.TYPE, buildings: Array[Building]):
	var target_buildings: Array[Building]
	
	for building in buildings:
		if type == building.type:
			target_buildings.append(building)
	
	return target_buildings


func remove_electricity(building: Building, amount: int):
	building.electricity = max(0, building.electricity - amount)

func remove_water(building: Building, amount: int):
	building.water = max(0, building.water - amount)

func get_buildings_in_cross(building: Building, buildings: Array[Building]):
	var target_buildings: Array[Building]
	
	for target_building in buildings:
		if target_building.position.y == building.y or target_building.position.x == building.x:
			target_buildings.append(target_building)
	
	return target_buildings
