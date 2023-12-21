extends VBoxContainer


# Called when the node enters the scene tree for the first time.
func _ready():
	self.get_node("BtnLeave").pressed.connect(self._btn_leave_pressed)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _btn_leave_pressed():
	get_tree().quit()
