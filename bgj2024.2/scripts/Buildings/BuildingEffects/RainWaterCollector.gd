extends BuildingEffect

func activate_storm(building: Building, electricity: int, water: int):
	var new_water = water
	if building.current_tier == 1:
		new_water += 25
	elif building.current_tier == 2:
		new_water += 50
	else:
		new_water += 100
	return [electricity, new_water]
