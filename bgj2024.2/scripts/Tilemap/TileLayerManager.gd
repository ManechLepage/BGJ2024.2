class_name TileLayerManager
extends Node2D

@onready var ground: TileMapLayer = $Ground
@onready var buildings: TileMapLayer = $Buildings
@onready var preview: TileMapLayer = $Preview

@onready var buildings_data: Buildings = %Buildings

var odd_neighbours: Array[Vector2i] = [
	Vector2i(1, 0),
	Vector2i(0, 1),
	Vector2i(-1, 0),
	Vector2i(0, -1),
	Vector2i(1, 1),
	Vector2i(0, 2),
	Vector2i(0, -2),
	Vector2i(1, -1),
]

var even_neighbours: Array[Vector2i] = [
	Vector2i(0, -2),
	Vector2i(0, 2),
	Vector2i(1, 0),
	Vector2i(-1, 0),
	Vector2i(0, 1),
	Vector2i(-1, 1),
	Vector2i(-1, -1),
	Vector2i(0, -1)
]

func get_building_mouse_position():
	return get_ground_mouse_position() - Vector2i(0, 2)

func get_ground_mouse_position():
	return ground.local_to_map(get_local_mouse_position())


func get_all_buildings():
	var building_list: Array[Building]
	for building_position in buildings.get_used_cells():
		var building: Building = buildings_data.get_building_from_atlas(buildings.get_cell_atlas_coords(building_position)).duplicate(true)
		building.position = building_position
		building_list.append(building)
	return building_list


func get_neighbouring_positions(position: Vector2i, value:int=0):
	var neighbours: Array[Vector2i]
	if position.y % 2 == value:
		neighbours = even_neighbours
	else:
		neighbours = odd_neighbours
	return neighbours


func place_building_at_mouse_position(building: Building):
	place_building(building, get_building_mouse_position())

func place_building(building: Building, position: Vector2i):
	clear_previews()
	buildings.set_cell(position, 2, building.sprite_atlas)
	check_for_grid_expansion()


func place_preview_at_mouse_position(building: Building):
	place_preview(building, get_building_mouse_position())

func place_preview(building: Building, position: Vector2i):
	if has_ground(get_ground_mouse_position()):
		clear_previews()
		preview.set_cell(position, 2, building.sprite_atlas)


func place_ground_tile(position: Vector2i):
	ground.set_cell(position, 1, Vector2i(0, 0))


func is_mouse_open_tile():
	return is_open_tile(get_building_mouse_position()) and has_ground(get_ground_mouse_position())

func has_ground(position: Vector2i):
	if position in ground.get_used_cells():
		return true
	return false

func is_open_tile(position: Vector2i):
	if position in buildings.get_used_cells():
		return false
	return true

func clear_previews():
	for tile in preview.get_used_cells():
		preview.erase_cell(tile)


func check_for_grid_expansion():
	for building_tile in buildings.get_used_cells():
		var neighbours = get_neighbouring_positions(building_tile)
		for building_neighbour in neighbours:
			var ground_position: Vector2i = building_neighbour + building_tile + Vector2i(0, 2)
			if not has_ground(ground_position):
				place_ground_tile(ground_position)


func get_texture(atlas_coords: Vector2i):
	var atlas: TileSetAtlasSource = ground.tile_set.get_source(2)
	var atlas_image = atlas.texture.get_image()
	var tile_image = atlas_image.get_region(atlas.get_tile_texture_region(atlas_coords))
	return ImageTexture.create_from_image(tile_image)
