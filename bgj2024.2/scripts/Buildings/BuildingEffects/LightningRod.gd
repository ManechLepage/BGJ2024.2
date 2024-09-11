extends BuildingEffect

func activate_storm(building: Building, electricity: int, water: int):
	var new_electricity = electricity
	if building.current_tier == 1:
		new_electricity += 50
	elif building.current_tier == 2:
		new_electricity += 80
	else:
		new_electricity += 150
	return [new_electricity, water]
