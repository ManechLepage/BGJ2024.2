class_name TurnManager
extends Node

@onready var turn_label: Label = %TurnLabel
@onready var next_storm_label: Label = %NextStormLabel

@onready var money_label: Label = %Money
@onready var electricity_label: Label = %Electricity
@onready var water_label: Label = %Water

@onready var choice: Panel = %Choice
@onready var see_board_button: Button = %SeeBoardButton

@onready var buildings: Buildings = %Buildings
@onready var input_manager: InputManager = %InputManager
@onready var placement_manager: PlacementManager = %PlacementManager
@onready var menu_manager: MenuManager = %MenuManager

var turn: int = 9

var money: int = 20
var electricity: int = 100
var water: int = 100

var choices: Array[Building]

var total_money: int = money

signal finished_choice

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
	total_money += total[0]
	
	update_turn()
	input_manager.finishing_turn = false
	if electricity < 0 or water < 0:
		menu_manager.on_death()

func _on_start_turn() -> void:
	choice.visible = true
	see_board_button.visible = true
	choices.clear()
	for i in range(3):
		choices.append(get_random_building())
		choice.get_child(4).get_child(i).load_building(choices[i])

func get_random_building():
	return buildings.get_random_building()

func _on_building_1_pressed() -> void:
	choice.visible = false
	see_board_button.visible = false
	placement_manager.current_selected_building = choices[0]
	finished_choice.emit()

func _on_building_2_pressed() -> void:
	choice.visible = false
	see_board_button.visible = false
	placement_manager.current_selected_building = choices[1]
	finished_choice.emit()

func _on_building_3_pressed() -> void:
	choice.visible = false
	see_board_button.visible = false
	placement_manager.current_selected_building = choices[2]
	finished_choice.emit()

func _on_finished_calculating_storm(total: Array) -> void:
	electricity += total[0]
	water += total[1]
	update_turn()

func _on_see_board_button_pressed() -> void:
	choice.visible = not choice.visible
