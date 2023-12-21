extends Node

var config = ConfigFile.new()
var planets_name = []
var planets_dictionnary : Dictionary = {}

var planets_scenes: Dictionary ={}
var planet_camera: Camera3D = null
var planet_camera2: Node3D = null

func _ready():
	var err = config.load("res://config/planets.cfg")

	if err != OK:
		print("config error !")
		print(err)
		return
		
	planets_name = config.get_value("PLANETS","PLANETS")
	
	for planet_name in planets_name:
		var planet = {
			"size": config.get_value(planet_name, "SIZE"),
			"dist_to_parent": config.get_value(planet_name, "ORBIT_DIST"),
			"planet_material": "res://ressources/materials/" + config.get_value(planet_name, "MATERIAL") +".tres",
			"orbite": config.get_value(planet_name, "ORBITE"),
			"parent": config.get_value(planet_name, "PARENT", "")
		}
		planets_dictionnary[planet_name]=planet
	for planet in planets_dictionnary:
		print(planets_dictionnary[planet])

func _process(delta):
	pass
