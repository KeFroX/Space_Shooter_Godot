extends Node

var asteroids_cshapes : Dictionary = {}
var asteroids_png : Dictionary = {}


# Called when the node enters the scene tree for the first time.
func _ready():
	asteroids_cshapes["LARGE"] = preload("res://ressources/asteroid_cshap_big.tres")
	asteroids_cshapes["MEDIUM"] = preload("res://ressources/asteroid_cshap_medium.tres")
	asteroids_cshapes["SMALL"] = preload("res://ressources/asteroid_cshap_tiny.tres")

	asteroids_png["LARGE"] = preload("res://assets/texture/asteroid/asteroidBrown_big1.png")
	asteroids_png["MEDIUM"] = preload("res://assets/texture/asteroid/asteroidBrown_med1.png")
	asteroids_png["SMALL"] = preload("res://assets/texture/asteroid/asteroidBrown_tiny1.png")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
