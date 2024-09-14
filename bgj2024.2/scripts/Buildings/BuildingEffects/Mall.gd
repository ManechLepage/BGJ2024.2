extends BuildingEffect

func activate(building: Building, buildings: Array[Building]):
	var surrounding_buildings: Array[Building] = parent.get_surrounding_buildings(building, buildings)
	
	var value: int
	for target_building in surrounding_buildings:
		value += target_building.current_tier
	
	if building.current_tier == 3:
		value *= 2
	
	if building.current_tier > 1:
		building.electricity -= 1
		building.water -= 1
		building.money += 2
	
	building.money += value
