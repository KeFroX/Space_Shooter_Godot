extends Control

@onready var score = $VBoxContainer/LblScore:
	set(value):
		score.text = "Score : " + str(value)
		
@onready var game_level = $VBoxContainer/LblLevel:
	set(value):
		game_level.text = "Niveau : " + str(value)
		
@onready var lives = $VBoxContainer/Lives

var ui_life_scene = preload("res://scenes/games/space_shooter/ui_life.tscn")

func _ready():
	pass
	
func init_lives(amount):
	for ul in lives.get_children():
		ul.queue_free()
	for i in amount:
		var ul = ui_life_scene.instantiate()
		lives.add_child(ul)
