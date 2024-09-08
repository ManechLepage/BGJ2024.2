extends BuildingEffect

func activate_storm(building: Building, electricity: int, water: int):
	var new_electricity = electricity
	if building.current_tier == 1:
		new_electricity += 10
	elif building.current_tier == 2:
		new_electricity += 15
	else:
		new_electricity += 25
	return [new_electricity, water]
