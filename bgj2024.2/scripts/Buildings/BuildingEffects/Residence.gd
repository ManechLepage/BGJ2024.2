extends BuildingEffect

func activate(building: Building, buildings: Array[Building]):
	var affected_buildings: Array[Building] = parent.get_surrounding_buildings(building, buildings)
	var filtered_affected_buildings: Array[Building] = parent.filter_buildings_by_type(Building.TYPE.COMERCIAL, affected_buildings)
	
	if building.current_tier == 1:
		building.money += len(filtered_affected_buildings)
	else:
		building.money += len(filtered_affected_buildings) * 2
	
	if building.current_tier > 1:
		building.money += 2
	
	if building.current_tier > 2:
		building.money += 1
