extends BuildingEffect

func activate(building: Building, buildings: Array[Building]):
	var affected_buildings: Array[Building] = parent.get_surrounding_buildings(building, buildings)
	var filtered_affected_buildings: Array[Building] = parent.filter_buildings_by_type(Building.TYPE.RESIDENTIAL, affected_buildings)
	
	if building.current_tier < 3:
		parent.add_revenue(building, len(filtered_affected_buildings))
	else:
		parent.add_revenue(building, len(filtered_affected_buildings) * 2)
	
	if building.current_tier > 1:
		building.electricity -= 1
