extends Control
signal quit
signal restart
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass





func _on_restart_pressed():
	emit_signal("restart", restart)


func _on_quit_pressed():
	emit_signal("quit",quit)
