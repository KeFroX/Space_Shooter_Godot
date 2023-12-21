extends Node

var path = "res://config/skin.cfg"

var skin_config = ConfigFile.new()
var element_dictionnary : Dictionary = {}

var textures_ship : Dictionary = {}
var textures_fire_mouvement : Dictionary = {}
var textures_fire_boost : Dictionary = {}
var textures_asteroid : Dictionary = {}
var cshapes_asteroid : Dictionary = {}
var textures_laser : Dictionary = {}
var texture_laser : Texture2D :
	get:
		return textures_laser[player["color_laser"]]
var player

func _ready():
	var err = skin_config.load(path)

	if err != OK:
		return
		
	var elements = skin_config.get_value("ELEMENTS","ELEMENTS")
	for element in elements:
		var e = {
			"color" = skin_config.get_value(element, "COLOR"),
		}
		element_dictionnary[element] = e
	
	for l in element_dictionnary["LASER"]["color"]:
		textures_laser[l] = ResourceLoader.load("res://assets/texture/laser/laser_" + l + ".png")
	
	for s in element_dictionnary["SHIP"]["color"]:
		textures_ship[s] = ResourceLoader.load("res://assets/texture/ship/player_ship_" + s +".png")
	
	for f in element_dictionnary["FIRE"]["color"]:
		textures_fire_mouvement[f] = ResourceLoader.load("res://assets/texture/fire/fire_" + f + "_mouvement.png")
	
	textures_asteroid["BIG"] ={}
	textures_asteroid["MEDIUM"] ={}
	textures_asteroid["TINY"] ={}
	
	for a in element_dictionnary["ASTEROID"]["color"]:
		textures_asteroid["BIG"][a] = ResourceLoader.load("res://assets/texture/asteroid/asteroid_" + a + "_big.png")
		textures_asteroid["MEDIUM"][a] = ResourceLoader.load("res://assets/texture/asteroid/asteroid_" + a + "_med.png")
		textures_asteroid["TINY"][a] = ResourceLoader.load("res://assets/texture/asteroid/asteroid_" + a + "_tiny.png")

	
	player = {
		"color_laser" = skin_config.get_value("PLAYER", "COLOR_LASER"),
		"color_ship" = skin_config.get_value("PLAYER", "COLOR_SHIP"),
		"color_fire" = skin_config.get_value("PLAYER", "COLOR_FIRE"),
		"color_asteroid" = skin_config.get_value("PLAYER", "COLOR_ASTEROID"),
	}
	
	cshapes_asteroid["BIG"] = preload("res://ressources/asteroid_cshap_big.tres")
	cshapes_asteroid["MEDIUM"] = preload("res://ressources/asteroid_cshap_medium.tres")
	cshapes_asteroid["TINY"] = preload("res://ressources/asteroid_cshap_tiny.tres")

	
func change_skin():
	skin_config.set_value("PLAYER", "COLOR_LASER", player["color_laser"])
	skin_config.set_value("PLAYER", "COLOR_SHIP", player["color_ship"])
	skin_config.set_value("PLAYER", "COLOR_FIRE", player["color_fire"])
	skin_config.set_value("PLAYER", "COLOR_ASTEROID", player["color_asteroid"])
	skin_config.save(path)
