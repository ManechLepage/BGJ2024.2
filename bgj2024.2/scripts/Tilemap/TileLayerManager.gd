class_name TileLayerManager
extends Node2D

@onready var ground: TileMapLayer = $Ground
@onready var buildings: TileMapLayer = $Buildings
@onready var preview: TileMapLayer = $Preview

@onready var sound_manager: SoundManager = %SoundManager
@onready var buildings_data: Buildings = %Buildings

@export var open_preview_color: Color
@export var denied_preview_color: Color
@export var merging_preview_color: Color

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
		var info = buildings_data.get_building_from_atlas(buildings.get_cell_atlas_coords(building_position))
		var building: Building = info[0]
		building.current_tier = info[1]
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


func can_merge_at_mouse_position(building: Building):
	return can_merge(get_building_mouse_position(), building)

func can_merge(position: Vector2i, building: Building):
	var tier = building.current_tier
	var saved_building: Building = building.duplicate(true)
	saved_building.current_tier = tier
	var data = buildings_data.get_building_from_atlas(buildings.get_cell_atlas_coords(position))
	var target_building: Building = data[0]
	if target_building:
		target_building.current_tier = data[1]
		if target_building.name == saved_building.name:
			return target_building.current_tier == saved_building.current_tier


func place_building_at_mouse_position(building: Building):
	place_building(building, get_building_mouse_position())

func place_building(building: Building, position: Vector2i):
	sound_manager.play_place_building()
	clear_previews()
	buildings.set_cell(position, 2, building.sprite_atlas + Vector2i(0, building.current_tier - 1))
	building.position = position
	check_for_grid_expansion()


func merge_building_at_mouse_position(building: Building):
	merge_building(building, get_building_mouse_position())

func merge_building(building: Building, position: Vector2i):
	sound_manager.play_merge_building()
	clear_previews()
	buildings.erase_cell(position)
	if building.current_tier == 1:
		buildings.set_cell(position, 2, building.sprite_atlas + Vector2i(0, 1))
	else:
		buildings.set_cell(position, 2, building.sprite_atlas + Vector2i(0, 2))


func place_preview_at_mouse_position(building: Building):
	place_preview(building, get_building_mouse_position())

func place_preview(building: Building, position: Vector2i):
	if has_ground(get_ground_mouse_position()):
		preview.modulate = update_preview_color(position, building)
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

func debug_positions(positions: Array[Vector2i]):
	for position in positions:
		preview.set_cell(position, 2, Vector2i(5, 0))


func update_preview_color(position: Vector2i, building: Building):
	if can_merge(position, building):
		return merging_preview_color
	elif is_open_tile(position):
		return open_preview_color
	return denied_preview_color
