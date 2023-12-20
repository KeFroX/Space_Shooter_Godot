extends Control

signal change_skin

@onready var laser_texture : TextureRect = $VBoxContainer/HBoxLaser/LaserTexture
@onready var ship_texture : TextureRect = $VBoxContainer/HBoxShip/ShipTexture
@onready var fire_texture : TextureRect = $VBoxContainer/HBoxFire/FireTexture
@onready var asteroid_texture : TextureRect = $VBoxContainer/HBoxAsteroid/AsteroidTexture
#var laser_textures : Dictionary = {}
#var ship_textures : Dictionary = {}
#var fire_textures : Dictionary = {}

var laser_list : Array = []
var ship_list : Array = []
var fire_list : Array = []
var asteroid_list : Array = []

func _ready():
	laser_list = GlobalSkin.element_dictionnary["LASER"]["color"]
	ship_list = GlobalSkin.element_dictionnary["SHIP"]["color"]
	fire_list = GlobalSkin.element_dictionnary["FIRE"]["color"]
	asteroid_list = GlobalSkin.element_dictionnary["ASTEROID"]["color"]
	
	laser_texture.texture = GlobalSkin.textures_laser[laser_list[0]]
	ship_texture.texture = GlobalSkin.textures_ship[ship_list[0]]
	fire_texture.texture = GlobalSkin.textures_fire_mouvement[fire_list[0]]
	asteroid_texture.texture = GlobalSkin.textures_asteroid["BIG"][asteroid_list[0]]
	

func _on_btn_next_ship_pressed():
	var color_ship = ship_list.pop_front()
	ship_list.append(color_ship)
	ship_texture.texture = GlobalSkin.textures_ship[ship_list[0]]


func _on_btn_previous_ship_pressed():
	var color_ship = ship_list.pop_back()
	ship_list.insert(0, color_ship)
	ship_texture.texture = GlobalSkin.textures_ship[ship_list[0]]


func _on_btn_next_laser_pressed():
	var color_laser = laser_list.pop_front()
	laser_list.append(color_laser)
	laser_texture.texture = GlobalSkin.textures_laser[laser_list[0]]


func _on_btn_previous_laser_pressed():
	var color_laser = laser_list.pop_back()
	laser_list.insert(0, color_laser)
	laser_texture.texture = GlobalSkin.textures_laser[laser_list[0]]


func _on_btn_previous_fire_pressed():
	var color_fire = fire_list.pop_front()
	fire_list.append(color_fire)
	fire_texture.texture = GlobalSkin.textures_fire_mouvement[fire_list[0]]


func _on_btn_next_fire_pressed():
	var color_fire = fire_list.pop_back()
	fire_list.insert(0, color_fire)
	fire_texture.texture = GlobalSkin.textures_fire_mouvement[fire_list[0]]

func _on_btn_previous_asteroid_pressed():
	var color_asteroid = asteroid_list.pop_front()
	asteroid_list.append(color_asteroid)
	asteroid_texture.texture = GlobalSkin.textures_asteroid["BIG"][asteroid_list[0]]


func _on_btn_next_asteroid_pressed():
	var color_asteroid = asteroid_list.pop_front()
	asteroid_list.append(color_asteroid)
	asteroid_texture.texture = GlobalSkin.textures_asteroid["BIG"][asteroid_list[0]]


func _on_btn_save_pressed():
	GlobalSkin.player["color_laser"] = laser_list[0]
	GlobalSkin.player["color_ship"] = ship_list[0]
	GlobalSkin.player["color_fire"] = fire_list[0]
	GlobalSkin.player["color_asteroid"] = asteroid_list[0]
	emit_signal("change_skin")

