extends Node3D


# Called when the node enters the scene tree for the first time.
func _ready():
	AutoLoadPlanet.planet_camera = $Camera3D
	AutoLoadPlanet.planet_camera2 = $Camroot
	
	var dictionary : Dictionary = {}
	var planet_scene_preload = preload("res://scenes/system/planet.tscn")
		
	for planet_name in AutoLoadPlanet.planets_name :
		var planet_scene = planet_scene_preload.instantiate()
		var planet = AutoLoadPlanet.planets_dictionnary[planet_name]
		planet_scene.name = planet_name
		planet_scene.size = planet["size"]
		planet_scene.dist_to_parent = planet["dist_to_parent"]
		planet_scene.planet_material = ResourceLoader.load(planet["planet_material"])
		planet_scene.orbite = planet["orbite"]
		if (planet["parent"] != ""):
			dictionary[AutoLoadPlanet.config.get_value(planet_name, "PARENT")].add_child(planet_scene)			
		else :
			self.add_child(planet_scene)
			
		dictionary[planet_name] = planet_scene
	self.remove_child($Camera3D)
	self.remove_child($Camroot)
	dictionary["Sun"].add_child(AutoLoadPlanet.planet_camera2)
	AutoLoadPlanet.planets_scenes = dictionary	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

