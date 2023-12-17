extends ToreWorldRigidBody
class_name Laser

@export var life_time = 100

@export var speed := 500.0
var mouvement_vector := Vector2(0, -1)

func _ready():
	pass

func _process(delta):
	if life_time > 0:
		life_time -= 1
	else :
		queue_free()


func _physics_process(delta):
	global_position += mouvement_vector.rotated(rotation) * speed * delta


func _on_body_entered(body):
	if body is Asteroid:
		var asteroid = body
		asteroid.explode()
		queue_free()
