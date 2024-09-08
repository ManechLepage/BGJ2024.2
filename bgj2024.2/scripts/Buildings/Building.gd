class_name Building
extends Resource

enum TYPE {RESIDENTIAL, COMERCIAL, INDUSTRIAL}
enum RARITY {COMMON, RARE}

@export var name: String
@export var type: TYPE
@export var rarity: RARITY
@export_group("Costs")
@export var water: int
@export var electricity: int
@export var money: int
@export_group("Sprite")
@export var sprite_atlas: Vector2i
@export_group("Text")
@export_multiline var description: String
@export_multiline var tier_2_description: String
@export_multiline var tier_3_description: String

var position: Vector2i
var current_tier: int = 1
