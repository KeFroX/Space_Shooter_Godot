extends RigidBody2D
class_name ToreWorldRigidBody


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
	
func set_position_in_toric_world(toric_size):
	var toric_width = toric_size.x*2
	var toric_height = toric_size.y*2

	var current_position = global_position
	if current_position.x < 0:
		current_position.x = toric_width

	if current_position.x > toric_width:
		current_position.x = 0

	if current_position.y < 0:
		current_position.y = toric_height

	if current_position.y > toric_height:
		current_position.y = 0

	global_position = current_position
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
