extends BuildingEffect

func activate(building: Building, buildings: Array[Building]):
	building.electricity -= 2
	building.water -= 2
	if building.current_tier > 1:
		building.electricity -= 3
		building.water -= 3
	if building.current_tier > 2:
		building.electricity -= 5
		building.water -= 5
