extends BuildingEffect

func activate_storm(building: Building, buildings: Array[Building], electricity: int, water: int):
	var new_electricity = electricity
	var new_water = water
	
	if building.current_tier == 1:
		new_electricity += len(buildings) * 2
		new_water += len(buildings) * 2
	elif building.current_tier == 2:
		new_electricity += len(buildings) * 4
		new_water += len(buildings) * 4
	elif building.current_tier == 3:
		new_electricity += len(buildings) * 8
		new_water += len(buildings) * 8
	
	building.data1 = new_electricity - electricity
	building.data2 = new_water - water
	
	return [new_electricity, new_water]
