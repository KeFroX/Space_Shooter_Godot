extends MarginContainer

var home_container : MarginContainer
var settings_container : MarginContainer

# Called when the node enters the scene tree for the first time.
func _ready():	
	home_container = $home_container
	settings_container = $settings_container
	
	for planete in AutoLoadPlanet.planets_name:
		var btn = Button.new()
		btn.pressed.connect(_on_btn_planete_pressed.bind(planete))
		btn.text = planete
		btn.custom_minimum_size = Vector2(100,10)
		home_container.get_node("v_box_btn_planets").add_child(btn)
		
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_btn_planete_pressed(planet_name):
	var box = home_container.get_node("v_box_info_planet")
	if box.get_node("lbl_name").text == planet_name : # cahche les infos
		box.set_visible(false)
		box.get_node("lbl_name").text = ""
	else : # affiche les infos
		box.set_visible(true)
		box.get_node("lbl_name").text = planet_name
#		AutoLoad.planet_camera.get_parent().remove_child(AutoLoad.planet_camera)
#		AutoLoad.planets_scenes[planet_name].add_child(AutoLoad.planet_camera)
		AutoLoadPlanet.planet_camera2.get_parent().remove_child(AutoLoadPlanet.planet_camera2)
		AutoLoadPlanet.planets_scenes[planet_name].add_child(AutoLoadPlanet.planet_camera2)
		
	var planet = AutoLoadPlanet.planets_dictionnary[planet_name]
	box.get_node("lbl_size").text = "Size : " + str(planet["size"])
	print(planet)
	
func _on_btn_leave_pressed():
	get_tree().quit()


func _on_btn_settings_pressed():
	if settings_container.visible:
		settings_container.set_visible(false)
		home_container.set_visible(true)
	else :
		settings_container.set_visible(true)
		home_container.set_visible(false)
