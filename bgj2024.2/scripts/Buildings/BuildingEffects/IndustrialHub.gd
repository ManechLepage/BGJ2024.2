extends BuildingEffect

func activate_storm(building: Building, buildings: Array[Building], electricity: int, water: int):
	var affected_buildings: Array[Building] = parent.get_buildings_in_cross(building, buildings)
	
	var new_electricity = electricity
	var new_water = water
	new_electricity += len(affected_buildings) * 5
	new_water += len(affected_buildings) * 5
	if building.current_tier > 1:
		new_electricity += len(affected_buildings) * 5
		new_water += len(affected_buildings) * 5
	if building.current_tier > 2:
		new_electricity += len(affected_buildings) * 10
		new_water += len(affected_buildings) * 10
	
	building.data1 = new_electricity - electricity
	building.data2 = new_water - water
	return [new_electricity, new_water]
