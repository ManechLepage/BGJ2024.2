extends Control
var building: Building

@onready var name_label: Label = %Name
@onready var description: RichTextLabel = %Description
@onready var revenue: Label = %Revenue
@onready var electricity: Label = %Electricity
@onready var water: Label = %Water
@onready var sprite: TextureRect = %Sprite

var main = load("res://ressources/TileSets/main.tres")

var keywords = {
	"elecrtricity" : "[img]res://graphics/UI/Icons/Elecricity.png[/img]",
	"water" : "[img]res://graphics/UI/Icons/Water.png[/img]",
	"revenue" : "[img]res://graphics/UI/Icons/Coin.png[/img]",
}

func load_building(_building: Building):
	building = _building
	
	name_label.text = building.name + " " + str(building.current_tier)
	description.text = enrich(get_description(building))
	
	var total = get_consumption_values(building)
	revenue.text = ": " + str(total[0])
	electricity.text = ": " + str(total[1])
	water.text = ": " + str(total[2])
	
	sprite.texture = get_tree().get_first_node_in_group("TileMap").get_texture(building.sprite_atlas + Vector2i(0, building.current_tier - 1))

func get_description(building: Building):
	if building.current_tier == 1:
		return building.description
	if building.current_tier == 2:
		if len(building.tier_2_description) > 1:
			return building.tier_2_description
		return building.description
	if len(building.tier_3_description) > 1:
		return building.tier_3_description
	return building.description

func enrich(text: String):
	for keyword in keywords.keys():
		text = text.replacen(keyword, keywords[keyword])
	return text

func get_consumption_values(building: Building):
	var total = [building.money, building.electricity, building.water]
	if building.current_tier > 1:
		total[0] += building.money_bonus_2
		total[1] += building.electricity_bonus_2
		total[2] += building.water_bonus_2
	if building.current_tier > 2:
		total[0] += building.money_bonus_3
		total[1] += building.electricity_bonus_3
		total[2] += building.water_bonus_3
	return total
