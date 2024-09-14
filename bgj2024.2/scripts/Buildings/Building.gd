class_name Building
extends Resource

enum TYPE {RESIDENTIAL, COMERCIAL, INDUSTRIAL}

@export var name: String
@export var type: TYPE
@export var rarity: float # 100 = very common, 10 = very rare
@export var start_apperance: int = -1
@export_group("Costs")
@export var water: int
@export var electricity: int
@export var money: int
@export_group("Sprite")
@export var sprite_atlas: Vector2i
@export_group("Text")
@export_multiline var description: String
@export_group("Higher Tiers")
@export_subgroup("Tier 2")
@export var water_bonus_2: int
@export var electricity_bonus_2: int
@export var money_bonus_2: int
@export_multiline var tier_2_description: String
@export_subgroup("Tier 3")
@export var water_bonus_3: int
@export var electricity_bonus_3: int
@export var money_bonus_3: int
@export_multiline var tier_3_description: String

var position: Vector2i
var current_tier: int = 1

var data1: int
var data2: int
