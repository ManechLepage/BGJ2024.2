class_name ScoreCalculator
extends Node

@onready var tile_layer_manager: TileLayerManager = %TileLayerManager
@onready var building_effects: BuildingEffects = %BuildingEffects

@export var animation_texture: PackedScene
@export var coin_texture: Texture2D
@export var electricity_texture: Texture2D
@export var water_texture: Texture2D

@onready var consumption_turn_total: Panel = %ConsumptionTurnTotal
@onready var revenue_turn_total: Panel = %RevenueTurnTotal
@onready var animation_target: Node2D = %AnimationTarget
@onready var animation_target_2: Node2D = %AnimationTarget2

@onready var lightning_count: Label = %LightningCount
@onready var water_count: Label = %WaterCount
@onready var revenue_count: Label = %RevenueCount

@onready var rain_particles: CPUParticles2D = %RainParticles

signal finished_calculating(total: Array)
signal finished_calculating_storm(total: Array)

var ANIMATION_SPEED: float = 1.0

const TIME_BETWEEN_TWEENS: float = 0.1
const TIME_AFTER_REVENUE: float = 0.5
const TWEEN_TIME: float = 0.8
const SCALE_TIME: float = 0.05
const TIME_BETWEEN_BUILDINGS = 0.3

const RANDOM_OFFSET: float = 0.5

@export var green: Color
@export var red: Color

func calculate():
	var buildings: Array[Building] = tile_layer_manager.get_all_buildings()
	#var buildings: Array[Building]
	#for building in temporary_buildings:
		#print(building.get_instance_id())
		#print(building.position)
		#var new_building = building.duplicate(true)
		#buildings.append(new_building)
	
	for building in buildings:
		print(building.current_tier)
		building_effects.activate_building(building, buildings)
	
	var turn_revenue: int = 0
	var turn_electricity: int = 0
	var turn_water: int = 0
	
	lightning_count.text = str(turn_electricity)
	water_count.text = str(turn_water)
	revenue_count.text = str(turn_revenue)
	
	for building in buildings:
		turn_electricity += building.electricity
		turn_water += building.water
	
	for building in buildings:
		turn_revenue += building.money
	
	var current_total :Array = [turn_revenue, turn_electricity, turn_water]
	
	for building in buildings:
		current_total = building_effects.activate_building_total_buff(building, current_total[0], current_total[1], current_total[2])
	
	consumption_turn_total.modulate.a = 1
	consumption_turn_total.visible = true
	for building in buildings:
		await animate_consumption(building)
		await get_tree().create_timer(TIME_BETWEEN_BUILDINGS * ANIMATION_SPEED).timeout
	
	await get_tree().create_timer(TIME_AFTER_REVENUE * ANIMATION_SPEED).timeout
	
	revenue_turn_total.modulate.a = 1
	revenue_turn_total.visible = true
	for building in buildings:
		await animate_revenue(building)
		await get_tree().create_timer(TIME_BETWEEN_BUILDINGS * ANIMATION_SPEED).timeout
	
	await get_tree().create_timer(TIME_AFTER_REVENUE * ANIMATION_SPEED).timeout
	revenue_count.text = str(current_total[0])
	lightning_count.text = str(current_total[1])
	water_count.text = str(current_total[2])
	
	var tween1 = get_tree().create_tween()
	var tween2 = get_tree().create_tween()
	
	tween1.tween_property(consumption_turn_total, "modulate:a", 0, 0.3 * ANIMATION_SPEED)
	tween2.tween_property(revenue_turn_total, "modulate:a", 0, 0.3 * ANIMATION_SPEED)
	
	await tween1.finished
	
	finished_calculating.emit(current_total)

func animate_consumption(building: Building):
	for i in range(building.electricity):
		animate(electricity_texture, tile_layer_manager.ground.map_to_local(building.position), animation_target_2.position)
		await get_tree().create_timer(TIME_BETWEEN_TWEENS * ANIMATION_SPEED).timeout
		lightning_count.text = str(int(lightning_count.text) + 1)
		animate_label(lightning_count)
	
	for i in range(building.water):
		animate(water_texture, tile_layer_manager.ground.map_to_local(building.position), animation_target_2.position)
		await get_tree().create_timer(TIME_BETWEEN_TWEENS * ANIMATION_SPEED).timeout
		water_count.text = str(int(water_count.text) + 1)
		animate_label(water_count)

func animate_revenue(building: Building):
	for i in range(building.money):
		animate(coin_texture, tile_layer_manager.ground.map_to_local(building.position), animation_target.position)
		await get_tree().create_timer(TIME_BETWEEN_TWEENS * ANIMATION_SPEED).timeout
		revenue_count.text = str(int(revenue_count.text) + 1)
		animate_label(revenue_count)

func animate(texture: Texture2D, position: Vector2, goal_position: Vector2):
	var sprite: TextureRect = animation_texture.instantiate()
	sprite.texture = texture
	position += Vector2(5, 10)
	sprite.position = position + Vector2(randf_range(-RANDOM_OFFSET, RANDOM_OFFSET), randf_range(-RANDOM_OFFSET, RANDOM_OFFSET))
	sprite.scale = Vector2(0.25, 0.25)
	
	%AnimationSprites.add_child(sprite)
	
	var tween = get_tree().create_tween()
	tween.tween_property(sprite, "position", goal_position, TWEEN_TIME * ANIMATION_SPEED).set_trans(Tween.TRANS_CUBIC)
	
	await tween.finished
	sprite.queue_free()

func animate_label(label: Label):
	var tween = get_tree().create_tween()
	tween.tween_property(label, "scale", Vector2(1.3, 1.3),SCALE_TIME * ANIMATION_SPEED)
	tween.tween_property(label, "scale", Vector2(1.0, 1.0),SCALE_TIME * ANIMATION_SPEED)

func _on_finished_turn() -> void:
	calculate()

func _on_start_storm() -> void:
	var buildings: Array[Building] = tile_layer_manager.get_all_buildings().duplicate(true)
	
	lightning_count.add_theme_color_override("font_color", green)
	water_count.add_theme_color_override("font_color", green)
	
	consumption_turn_total.visible = true
	consumption_turn_total.modulate.a = 1
	
	rain_particles.visible = true
	rain_particles.modulate.a = 1
	
	lightning_count.text = str(0)
	water_count.text = str(0)
	
	await get_tree().create_timer(1 * ANIMATION_SPEED).timeout
	var total: Array = [0, 0]
	for building in buildings:
		total = building_effects.activate_building_storm(building, total[0], total[1])
		animate_storm(building)
		await get_tree().create_timer(0.1 * ANIMATION_SPEED).timeout
	
	await get_tree().create_timer(1 * ANIMATION_SPEED).timeout
	var tween1 = get_tree().create_tween()
	var tween2 = get_tree().create_tween()
	
	tween1.tween_property(consumption_turn_total, "modulate:a", 0, 0.3 * ANIMATION_SPEED)
	tween2.tween_property(rain_particles, "modulate:a", 0, 0.3 * ANIMATION_SPEED)
	
	await tween2.finished
	
	consumption_turn_total.visible = false
	rain_particles.visible = false
	
	lightning_count.add_theme_color_override("font_color", red)
	water_count.add_theme_color_override("font_color", red)
	
	finished_calculating_storm.emit(total)

func animate_storm(building: Building):
	if building.name == "Rain Collector":
		var value = 50
		if building.current_tier > 1:
			value += 30
		if building.current_tier > 2:
			value += 70
		for i in range(int(value / 2)):
			water_count.text = str(int(water_count.text) + 2)
			animate_label(water_count)
			await get_tree().create_timer(0.01 * ANIMATION_SPEED).timeout
			animate(water_texture, tile_layer_manager.ground.map_to_local(building.position), animation_target.position)
	elif building.name == "Lightning Rod":
		var value = 50
		if building.current_tier > 1:
			value += 30
		if building.current_tier > 2:
			value += 70
		for i in range(int(value / 2)):
			lightning_count.text = str(int(lightning_count.text) + 2)
			animate_label(lightning_count)
			await get_tree().create_timer(0.01 * ANIMATION_SPEED).timeout
			animate(electricity_texture, tile_layer_manager.ground.map_to_local(building.position), animation_target.position)
