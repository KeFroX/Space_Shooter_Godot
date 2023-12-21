extends ToreWorldRigidBody
class_name Asteroid

signal exploded(pos, size, points)

@onready var sprite = $Sprite2D
@onready var cshape = $CollisionShape2D

@export var size := AsteroidSize.BIG
enum AsteroidSize{BIG, MEDIUM, TINY}

var movement_vector := Vector2(0, -1)
var speed := 50



var points : int:
	get:
		match size:
			AsteroidSize.BIG:
				return 25
			AsteroidSize.MEDIUM:
				return 50
			AsteroidSize.TINY:
				return 100
		return 0
	
func _ready():
	rotation = randf_range(0, 2*PI)
	
	if AsteroidSize.find_key(size) in AsteroidSize:		
		sprite.texture = GlobalSkin.textures_asteroid[AsteroidSize.find_key(size)][GlobalSkin.player["color_asteroid"]]
		cshape.shape = GlobalSkin.cshapes_asteroid[AsteroidSize.find_key(size)]
		match size:
			AsteroidSize.BIG:
				speed = randi_range(50, 100)
			AsteroidSize.MEDIUM:
				speed = randi_range(100, 150)
			AsteroidSize.TINY:
				speed = randi_range(100, 200)
		
func _process(delta):
	global_position += movement_vector.rotated(rotation) * speed * delta
	pass

func explode():
	emit_signal("exploded", global_position, size, points)
	queue_free()
