extends Node2D

@onready var player = $Player
@onready var lasers = $Lasers
@onready var asteroids = $Asteroids
@onready var toric_world_shape = $Toric_world/CollisionShape2D
@onready var sounds = $Sounds
@onready var hud = $UI/HUD
@onready var ui_pause = $UI/PauseMenu
@onready var ui_settings_menu = $UI/SettingsMenu

var asteroid_scene = preload("res://scenes/asteroid.tscn")

var score := 0:
	set(value):
		score = value
		hud.score = score
		
var game_level := 1:
	set(value):
		game_level = value
		hud.game_level = game_level
var small_asteroid_in_level : 
	get :
		return game_level * 4
var small_asteroid_explode := 0

var lives = 3:
	set(value):
		lives = value
		hud.init_lives(lives)


func _ready():
	player.connect("laser_shoot", _on_player_laser_shoot)
	
	ui_pause.connect("game_resume", game_pause)
	ui_pause.connect("game_restart", game_restart)
	ui_pause.connect("game_settings_menu_go", game_settings_menu_go)
	
	ui_settings_menu.connect("game_settings_menu_back", game_settings_menu_back)
	
	for asteroid in asteroids.get_children():
		asteroid.connect("exploded", _on_asteroid_exploded)

func _process(delta):
	if Input.is_action_just_pressed("escape"):
		game_pause()

func game_settings_menu_back():
	ui_pause.visible = true
	ui_settings_menu.visible = false

func game_settings_menu_go():
	ui_pause.visible = false
	ui_settings_menu.visible = true

func game_pause():
	if get_tree().paused == true:
		ui_pause.visible = false
		get_tree().paused = false
	else :
		get_tree().paused = true
		ui_pause.visible = true
	
func game_restart():
	get_tree().reload_current_scene()
	if get_tree().paused == true:
		ui_pause.visible = false
		get_tree().paused = false
	
func _on_asteroid_exploded(pos, size, points):
	score += points
	if !Asteroid.AsteroidSize.SMALL == size:
		for i in range(2):
			match size:
				Asteroid.AsteroidSize.LARGE:
					spawn_asteroid(pos, Asteroid.AsteroidSize.MEDIUM)				
				Asteroid.AsteroidSize.MEDIUM:
					spawn_asteroid(pos, Asteroid.AsteroidSize.SMALL)
	else :
		small_asteroid_explode += 1
		print(small_asteroid_explode)
		if small_asteroid_explode == small_asteroid_in_level:
			next_level()
	
func next_level():
	game_level += 1
	small_asteroid_explode = 0
	for l in lasers.get_children():
		l.queue_free()
	var witdh = toric_world_shape.position.x * 2
	var height = toric_world_shape.position.y * 2
	for i in game_level:		
		var random_pos = Vector2(randi_range(0, witdh), randi_range(0, height))
		spawn_asteroid(random_pos, Asteroid.AsteroidSize.LARGE)
	print("Niveau : " + str(game_level))
	
	
	
	
						
func spawn_asteroid(pos, size):
	var a = asteroid_scene.instantiate()
	a.global_position = pos
	a.size = size
	a.connect("exploded", _on_asteroid_exploded)
	asteroids.call_deferred("add_child", a)


func _on_toric_world_body_exited(body):	
	if body.has_method("set_position_in_toric_world"):		
		body.set_position_in_toric_world(toric_world_shape.position)

func _on_player_laser_shoot(laser):
	$Sounds/LaserShoot.play()
	lasers.add_child(laser)
