class_name RentManager
extends Node

@onready var turn_manager: TurnManager = %TurnManager
@onready var label: Label = %Label
@onready var menu_manager: MenuManager = %MenuManager

enum DIFFICULTY {EASY, MEDIUM, HARD, IMPOSSIBLE}
var difficulty: DIFFICULTY

var rent: int
var rent_index: int = 1
var rent_exponent: float = 1
var rent_rule = 1

func load_difficulty():
	if difficulty == DIFFICULTY.EASY:
		rent_rule = 0.5
		rent_exponent = 1.7
	elif difficulty == DIFFICULTY.MEDIUM:
		rent_rule = 0.4
		rent_exponent = 1.9
	elif difficulty == DIFFICULTY.HARD:
		rent_rule = 0.8
		rent_exponent = 1.93
	else:
		rent_rule = 0.7
		rent_exponent = 2.0

func _ready() -> void:
	rent = (rent_rule * ((rent_index * 10) ** rent_exponent))
	update_label()
	var calculated_rent = 1
	for i in range(10):
		calculated_rent += 1

func _on_start_storm() -> void:
	turn_manager.money -= rent
	rent_index += 1
	rent = (rent_rule * ((rent_index * 10) ** rent_exponent))
	update_label()
	if turn_manager.money < 0:
		menu_manager.on_death()

func update_label():
	label.text = "Rent: " + str(rent)
