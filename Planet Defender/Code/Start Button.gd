extends Button

func _on_start_button_pressed():
	print("button clicked succesfully")
	get_tree().change_scene_to_file("res://Level_Select_menu.tscn")
	hide()
	pass # Replace with function body.
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
