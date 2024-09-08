extends BuildingEffect

func activate_storm(building: Building, electricity: int, water: int):
	var new_water = water
	if building.current_tier == 1:
		new_water += 10
	elif building.current_tier == 2:
		new_water += 15
	else:
		new_water += 25
	return [electricity, new_water]
