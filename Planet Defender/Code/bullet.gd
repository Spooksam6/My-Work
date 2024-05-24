extends Area2D
class_name bulleted
var speed = 3000
@export var bullet : PackedScene

signal death
# Called when the node enters the scene tree for the first time.
func _ready():

	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	position += transform.x * speed * delta
	pass
func _on_body_entered(body):
	if body.is_in_group("mobs"):
		emit_signal('death',death)
		body.queue_free()
		if get_parent().get_node("Mouse_Moved_Player") != null:
			get_parent().get_node("Mouse_Moved_Player").add_coins(1)
	queue_free()
