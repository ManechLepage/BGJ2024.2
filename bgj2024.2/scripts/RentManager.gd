class_name RentManager
extends Node

@onready var turn_manager: TurnManager = %TurnManager
@onready var label: Label = %Label

var rent: int
var rent_index: int = 0

var rent_ramp = [
	5,
	15,
	25,
	50,
	80,
	130,
	180
]

func _ready() -> void:
	rent = rent_ramp[rent_index]
	update_label()

func _on_start_storm() -> void:
	turn_manager.money -= rent
	rent_index += 1
	rent = rent_ramp[rent_index]
	update_label()

func update_label():
	label.text = "Rent: " + str(rent)
