extends BuildingEffect

func activate(building: Building, buildings: Array[Building]):
	var affected_buildings: Array[Building] = parent.get_surrounding_buildings(building, buildings)
	var filtered_affected_buildings: Array[Building] = parent.filter_buildings_by_type(Building.TYPE.RESIDENTIAL, affected_buildings)
	
	if building.current_tier < 2:
		building.money += len(filtered_affected_buildings)
	elif building.current_tier < 3:
		building.money += len(filtered_affected_buildings) * 2
	else:
		building.money += len(filtered_affected_buildings) * 3
	
	if building.current_tier > 1:
		building.electricity -= 1
	if building.current_tier > 2:
		building.water -= 1
		building.electricity -= 1
