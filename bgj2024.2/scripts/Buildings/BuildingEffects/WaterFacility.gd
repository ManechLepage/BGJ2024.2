extends BuildingEffect

func activate(building: Building, buildings: Array[Building]):
	if building.current_tier > 1:
		building.electricity -= 1

func activate_total_buff(building: Building, revenue: int, electricity: int, water: int):
	var buffed_water: float
	if building.current_tier < 3:
		buffed_water = water * 0.9
	else:
		buffed_water = water * 0.85
	
	var rounded_water: int = int(buffed_water)
	return [revenue, electricity, rounded_water]
