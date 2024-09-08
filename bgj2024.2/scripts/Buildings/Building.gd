class_name Building
extends Resource

enum TYPE {RESIDENTIAL, COMERCIAL, INDUSTRIAL}

@export var type: TYPE
@export_group("Costs")
@export var water: int
@export var electricity: int
@export var money: int
@export_group("Sprite")
@export var sprite_atlas: Vector2i
