class_name RentManager
extends Node

@onready var turn_manager: TurnManager = %TurnManager
@onready var label: Label = %Label
@onready var menu_manager: MenuManager = %MenuManager

enum DIFFICULTY {EASY, MEDIUM, HARD, IMPOSSIBLE}
var difficulty: DIFFICULTY

var rent: int
var rent_index: int = 1

var rent_rule = 0.03

func load_difficulty():
	if difficulty == DIFFICULTY.EASY:
		rent_rule = 0.02
	elif difficulty == DIFFICULTY.MEDIUM:
		rent_rule = 0.03
	elif difficulty == DIFFICULTY.HARD:
		rent_rule = 0.04
	else:
		rent_rule = 0.05

func _ready() -> void:
	rent = 0.03 * ((rent_index * 10) ** 2)
	update_label()

func _on_start_storm() -> void:
	turn_manager.money -= rent
	rent_index += 1
	rent = 0.03 * ((rent_index * 10) ** 2)
	update_label()
	if turn_manager.money < 0:
		menu_manager.on_death()

func update_label():
	label.text = "Rent: " + str(rent)
