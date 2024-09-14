extends BuildingEffect

func activate_storm(building: Building, buildings: Array[Building], electricity: int, water: int):
	var new_electricity = electricity
	if building.current_tier == 1:
		new_electricity += 25
	elif building.current_tier == 2:
		new_electricity += 50
	else:
		new_electricity += 100
	return [new_electricity, water]
