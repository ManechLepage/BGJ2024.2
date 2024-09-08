class_name TurnManager
extends Node

@onready var turn_label: Label = %TurnLabel
@onready var next_storm_label: Label = %NextStormLabel

@onready var money_label: Label = %Money
@onready var electricity_label: Label = %Electricity
@onready var water_label: Label = %Water

@onready var choice: Panel = %Choice

@onready var buildings: Buildings = %Buildings
@onready var input_manager: InputManager = %InputManager
@onready var placement_manager: PlacementManager = %PlacementManager

var turn: int = 0

var money: int = 0
var electricity: int = 100
var water: int = 100

var choices: Array[Building]

func _ready() -> void:
	_on_finished_calculating([0, 0, 0])

func update_turn():
	turn_label.text = "Turn: " + str(turn)
	next_storm_label.text = "Next Storm: " + str((floor(turn / 10) * 10) + 10)
	
	money_label.text = "Money: " + str(money)
	electricity_label.text = "Electricity: " + str(electricity)
	water_label.text = "Water: " + str(water)

func _on_finished_calculating(total) -> void:
	turn += 1
	money += total[0]
	electricity -= total[1]
	water -= total[2]
	update_turn()
	input_manager.finishing_turn = false

func _on_start_turn() -> void:
	choice.visible = true
	choices.clear()
	for i in range(3):
		choices.append(get_random_building())
		choice.get_child(4).get_child(i).load_building(choices[i])

func get_random_building():
	return buildings.buildings.pick_random()

func _on_building_1_pressed() -> void:
	choice.visible = false
	placement_manager.current_selected_building = choices[0]

func _on_building_2_pressed() -> void:
	choice.visible = false
	placement_manager.current_selected_building = choices[1]

func _on_building_3_pressed() -> void:
	choice.visible = false
	placement_manager.current_selected_building = choices[2]

func _on_finished_calculating_storm(total: Array) -> void:
	electricity += total[0]
	water += total[1]
	update_turn()
