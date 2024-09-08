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
	description.text = enrich(building.description)
	revenue.text = str(building.money)
	electricity.text = str(building.electricity)
	water.text = str(building.water)
	
	sprite.texture = get_tree().get_first_node_in_group("TileMap").get_texture(building.sprite_atlas)

func enrich(text: String):
	for keyword in keywords.keys():
		text = text.replacen(keyword, keywords[keyword])
	return text
