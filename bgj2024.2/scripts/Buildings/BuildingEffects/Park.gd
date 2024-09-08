extends BuildingEffect

func activate(building: Building, buildings: Array[Building]):
	var affected_buildings: Array[Building] = parent.get_surrounding_buildings(building, buildings)
	var filtered_affected_buildings: Array[Building] = parent.filter_buildings_by_type(Building.TYPE.RESIDENTIAL, affected_buildings)
	
	if building.current_tier < 3:
		for target_building in filtered_affected_buildings:
			parent.remove_electricity(target_building, 1)
	else:
		for target_building in filtered_affected_buildings:
			parent.remove_electricity(target_building, 2)
	
	if building.current_tier > 1:
		building.water -= 1
