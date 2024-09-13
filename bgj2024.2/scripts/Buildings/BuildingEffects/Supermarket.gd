extends BuildingEffect

func activate(building: Building, buildings: Array[Building]):
	var satisfy_needs: bool = false
	
	var surrounding_buildings: Array[Building] = parent.get_surrounding_buildings(building, buildings)
	
	if len(parent.filter_buildings_by_type(Building.TYPE.COMERCIAL, surrounding_buildings)) > 0:
		if len(parent.filter_buildings_by_type(Building.TYPE.INDUSTRIAL, surrounding_buildings)) > 0:
			if len(parent.filter_buildings_by_type(Building.TYPE.RESIDENTIAL, surrounding_buildings)) > 0:
				satisfy_needs = true
	
	if satisfy_needs:
		if building.current_tier == 1:
			building.money += 10
		elif building.current_tier == 2:
			building.money += 20
		else:
			building.money += 30
	
	if building.current_tier > 1:
		building.water -= 1
	
	if building.current_tier > 2:
		building.water -= 1
