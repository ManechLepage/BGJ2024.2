class_name TutorialManager
extends Node

var count: int = 0

@onready var turn_manager: TurnManager = %TurnManager

@onready var tutorial_1: Panel = %Tutorial1
@onready var description: Label = %Description
@onready var description_2: Label = %Description2

@onready var tutorial_2: Panel = %Tutorial2
@onready var description_1_1: Label = %Description1_1
@onready var description_1_2: Label = %Description1_2
@onready var description_1_3: Label = %Description1_3

@onready var tutorial_3: Panel = %Tutorial3
@onready var description_2_1: Label = %Description2_1


var first_start_turn: bool = true
var first_tutorial_3: bool = true

func load_text1():
	if GlobalInfo.has_played_tutorial:
		tutorial_1.visible = true
		description.visible = true
		description_2.visible = false

func _on_continue_button_pressed() -> void:
	if GlobalInfo.has_played_tutorial:
		count += 1
		if count == 1:
			description.visible = false
			description_2.visible = true
		else:
			tutorial_1.visible = false
			count = 0

func _on_input_manager_start_turn() -> void:
	if GlobalInfo.has_played_tutorial:
		if first_start_turn:
			first_start_turn = false
			tutorial_2.visible = true
			description_1_1.visible = true
			description_1_2.visible = false
			description_1_3.visible = false

func _on_continue_2_button_pressed() -> void:
	if GlobalInfo.has_played_tutorial:
		count += 1
		if count == 1:
			description_1_1.visible = false
			description_1_2.visible = true
		elif count == 2:
			description_1_2.visible = false
			description_1_3.visible = true
		else:
			count = 0
			tutorial_2.visible = false
			turn_manager.enable_buttons()

func _on_continue_3_button_pressed() -> void:
	if GlobalInfo.has_played_tutorial:
		tutorial_3.visible = false
		GlobalInfo.has_played_tutorial = false

func _on_turn_manager_finished_choice() -> void:
	if GlobalInfo.has_played_tutorial:
		if first_tutorial_3:
			first_tutorial_3 = false
			tutorial_3.visible = true
