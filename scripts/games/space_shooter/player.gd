extends ToreWorldRigidBody
class_name Player

signal laser_shoot(laser)

@onready var collion = $Collision
@onready var sprite : Sprite2D = $Sprite
@onready var sprite_fire : AnimatedSprite2D = $SpriteEffect
@onready var laser_position = $Laser

var laser_scene = preload("res://scenes/games/space_shooter/laser.tscn")

var is_shoot_cd = false
@export var shoot_cd : float = 0.3

@export var max_speed : int = 300
var max_reserve_boost = 200
var can_boost = true
var boost = 1

var reserve_boost = 200 :
	set(value):
		reserve_boost = value
		if value == 0:
			can_boost = false
		if !can_boost and value > 70:
			can_boost = true



func _ready():
	change_skin()
	
	
func change_skin():
	var path : String
	var ship = GlobalSkin.player["color_ship"]
	print(ship)
	var fire = GlobalSkin.player["color_fire"]
	sprite.texture = ResourceLoader.load("res://assets/texture/ship/player_ship_" + ship + ".png")
	
	path = "res://assets/texture/fire/fire_" + fire +"_boost.png"
	sprite_fire.sprite_frames.set_frame("boost", 0, ResourceLoader.load(path))
	
	path = "res://assets/texture/fire/fire_" + fire +"_mouvement.png"
	sprite_fire.sprite_frames.set_frame("mouvement", 0, ResourceLoader.load(path))

func _physics_process(delta):
	if Input.is_action_pressed("ui_boost") and can_boost:
		boost = 3
		max_speed = 500
		reserve_boost -= 1
	else:
		boost = 1
		max_speed = 300
		if reserve_boost < max_reserve_boost:
			reserve_boost += 1
	
	
	if Input.is_action_pressed("ui_up"):		
		apply_central_force(-transform.y*15000*delta*boost)
		
	if Input.is_action_pressed("ui_left"):
		apply_torque(-80000*delta)
		
	if Input.is_action_pressed("ui_right"):
		apply_torque(80000*delta)
		
	linear_velocity = linear_velocity.limit_length(max_speed)
		
func shoot_laser():
	var l = laser_scene.instantiate()
	l.global_position = laser_position.global_position
	l.rotation = rotation
	emit_signal("laser_shoot", l)


func _process(delta):
	if Input.is_action_pressed("ui_up") or Input.is_action_pressed("ui_left") or Input.is_action_pressed("ui_right"):
		if Input.is_action_pressed("ui_boost") and can_boost:
			sprite_fire.play("boost")
		else:
			sprite_fire.play("mouvement")		
	else:
		sprite_fire.play("stop")
	
	if Input.is_action_pressed("shoot"):
		if !is_shoot_cd:
			is_shoot_cd = true
			shoot_laser()
			await get_tree().create_timer(shoot_cd).timeout
			is_shoot_cd = false
