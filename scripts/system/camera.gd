extends Node3D


var camroot_h = -180
var camroot_v = 0
var cam_v_min = 75
var cam_v_max = -75
var h_sensitivity = 0.5
var v_sensitivity = 0.5
var h_acceleration = 10
var v_acceleration = 10
var is_rotating = false

#Zoom
var zoom_speed = 0.1
var min_zoom = -1.0
var max_zoom = 4.0

# Called when the node enters the scene tree for the first time.
func _ready():
	pass
	
func _input(event):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT:
			if event.pressed:
				is_rotating = true
			else:
				is_rotating = false
		elif event.button_index == MOUSE_BUTTON_RIGHT:
			if event.pressed:
				_reset_camera()	
		elif event.button_index == MOUSE_BUTTON_WHEEL_UP:
			if $h/v/z.position.z > min_zoom:
				$h/v/z.translate(Vector3.FORWARD*(zoom_speed))
		elif event.button_index == MOUSE_BUTTON_WHEEL_DOWN:
			if $h/v/z.position.z < max_zoom:
				$h/v/z.translate(Vector3.FORWARD*(-zoom_speed))
	elif event is InputEventMouseMotion and is_rotating:
		camroot_h -= event.relative.x * h_sensitivity
		camroot_v -= event.relative.y * v_sensitivity

			
func _reset_camera():
	camroot_h = -180
	camroot_v = 0
	$h/v/z.position.z = 0

func _physics_process(delta):
	if camroot_v < cam_v_max :
#		camroot_v = clamp(camroot_v, cam_v_min, cam_v_max)
		camroot_v = cam_v_max
		
	if camroot_v > cam_v_min :
		camroot_v = cam_v_min
	
	$h.rotation_degrees.y = camroot_h
	$h/v.rotation_degrees.x = camroot_v
	
