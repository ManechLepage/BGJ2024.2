extends BuildingEffect

func activate_total_buff(building: Building, buildings: Array[Building], revenue: int, electricity: int, water: int):
	var value = len(parent.filter_buildings_by_type(Building.TYPE.COMERCIAL, buildings))
	
	var percentage: float = 1 - (value / 100)
	var buffed_electricity: float
	if building.current_tier < 2:
		buffed_electricity = electricity * percentage
	elif building.current_tier < 3:
		buffed_electricity = electricity * (percentage * 2)
	else:
		buffed_electricity = electricity * (percentage * 3)
	
	var rounded_electricity: int = int(buffed_electricity)
	return [revenue, rounded_electricity, water]
