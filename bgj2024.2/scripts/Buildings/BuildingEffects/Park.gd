extends BuildingEffect

func activate(building: Building, buildings: Array[Building]):
	var affected_buildings: Array[Building] = parent.get_surrounding_buildings(building, buildings)
	var filtered_affected_buildings: Array[Building] = parent.filter_buildings_by_type(Building.TYPE.RESIDENTIAL, affected_buildings)
	
	var value: int = 1
	if building.current_tier > 1:
		value += 1
	if building.current_tier > 2:
		value += 1
	
	for target_building in filtered_affected_buildings:
		parent.remove_electricity(target_building, value)
		parent.remove_water(target_building, value)
	
	if building.current_tier > 1:
		building.water -= 1
	
	if building.current_tier > 2:
		building.water -= 1
		building.electricity -= 1
