extends ToreWorldRigidBody
class_name Asteroid

signal exploded(pos, size, points)

@onready var sprite = $Sprite2D
@onready var cshape = $CollisionShape2D

@export var size := AsteroidSize.LARGE
enum AsteroidSize{LARGE, MEDIUM, SMALL}

var movement_vector := Vector2(0, -1)
var speed := 50



var points : int:
	get:
		match size:
			AsteroidSize.LARGE:
				return 25
			AsteroidSize.MEDIUM:
				return 50
			AsteroidSize.SMALL:
				return 100
		return 0
	
func _ready():
	rotation = randf_range(0, 2*PI)
	
	if AsteroidSize.find_key(size) in AsteroidSize:		
		sprite.texture = AutoLoad.asteroids_png[AsteroidSize.find_key(size)]
		cshape.shape = AutoLoad.asteroids_cshapes[AsteroidSize.find_key(size)]
		match size:
			AsteroidSize.LARGE:
				speed = randi_range(50, 100)
			AsteroidSize.MEDIUM:
				speed = randi_range(100, 150)
			AsteroidSize.SMALL:
				speed = randi_range(100, 200)
		
func _process(delta):
	global_position += movement_vector.rotated(rotation) * speed * delta
	pass

func explode():
	emit_signal("exploded", global_position, size, points)
	queue_free()
