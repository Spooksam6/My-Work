extends Marker2D



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	rotate(get_angle_to(get_global_mouse_position())+190)
