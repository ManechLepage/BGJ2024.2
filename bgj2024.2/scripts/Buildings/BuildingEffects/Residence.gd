extends BuildingEffect

func activate(building: Building, buildings: Array[Building]):
	if building.current_tier > 1:
		building.money += 1
	
	if building.current_tier > 2:
		building.money += 2
		building.water += 1
