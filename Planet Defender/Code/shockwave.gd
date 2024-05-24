extends Area2D
var speed = 1000
@export var shockwave : PackedScene
# Called when the node enters the scene tree for the first time.
func _ready():
	print('yeeeah')
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	position += transform.x * speed * delta
	pass
func _on_body_entered(body):
	if body.is_in_group("mobs"):
		body.queue_free()
		get_parent().get_node("Mouse_Moved_Player").add_coins(1)
