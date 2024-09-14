extends BuildingEffect

func activate(building: Building, buildings: Array[Building]):
	building.money += GlobalInfo.apartment_value

func activate_storm(building: Building, buildings: Array[Building], electricity: int, water: int):
	GlobalInfo.apartment_value += building.current_tier
	return [electricity, water]
