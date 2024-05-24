extends Area2D
var speed = 1000
@export var bullet : PackedScene
var cc
var target
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	position += transform.x * speed * delta
	pass
func explode():
	$AnimatedSprite2D.play("explode")
	$Timer.start()
	cc = get_parent().get_child_count()
	for i in range(0,cc):
		target = get_parent().get_child(i)
		if target.is_in_group("mobs"):
			if target.marked_for_death:
				target.queue_free()
				get_parent().get_node("Mouse_Moved_Player").add_coins(1)
func _on_body_entered(body):
	if body.is_in_group("mobs"):
		explode()
		speed = 0
func _on_explosion_range_body_entered(body):
	if body.is_in_group("mobs"):
		body.marked_for_death = true
func _on_explosion_range_body_exited(body):
	if body.is_in_group("mobs"):
		body.marked_for_death = false


func _on_timer_timeout():
	queue_free()
	pass # Replace with function body.
