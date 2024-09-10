extends BuildingEffect

func activate(building: Building, buildings: Array[Building]):
	var affected_buildings: Array[Building] = parent.get_surrounding_buildings(building, buildings)
	var filtered_affected_buildings: Array[Building] = parent.filter_buildings(building, affected_buildings)
	
	if building.current_tier < 3:
		building.money += len(filtered_affected_buildings)
	else:
		building.money += len(filtered_affected_buildings) * 2
	
	if building.current_tier > 1:
		building.money += 1
	
	print(building.money)
