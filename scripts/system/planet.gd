extends Node3D
@export var speed_rotation : float = 1
@export var speed_orbite : float = 10
var planet_material : BaseMaterial3D = null

var planet = MeshInstance3D
var dist_to_parent = 0.0
var size :float = 1.0
var orbite : bool = false

# Called when the node enters the scene tree for the first time.
func _ready():
	planet = $Planet
	planet.set_material_override(planet_material)
	translate(Vector3.FORWARD*(dist_to_parent))
	global_scale(Vector3(size, size, size))
	dist_to_parent = global_position.distance_to(get_parent().global_position)
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	planet.rotate_y(speed_rotation*delta)
	if(orbite):
		
		translate(delta*Vector3.RIGHT*speed_orbite)
		
		look_at(get_parent().global_position)
		var newDist = global_position.distance_to(get_parent().global_position)-dist_to_parent

		translate(Vector3.FORWARD*newDist*delta)
	
