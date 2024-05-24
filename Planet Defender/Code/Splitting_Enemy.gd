extends RigidBody2D
@export var speed = 500
var player_position
var target_position
var timer = 0
@onready var player = get_parent().get_node("Mouse_Moved_Player")
@export var mob : PackedScene
var marked_for_death = false
func _ready():
	$AnimatedSprite2D.play()
	#$ShootTimer.start()
func die():
	print("died")
	var m1 = mob.instantiate()
	var m2 = mob.instantiate()
	m1.transform = $left_marker.global_transform
	m2.transform = $right_marker.global_transform
	get_parent().add_child(m1)
	get_parent().add_child(m2)
	queue_free()
func _physics_process(_delta):
	player_position = player.position
	target_position = (player_position - position).normalized()
	
	if position.distance_to(player_position) > 5:

		linear_velocity = target_position * speed
		gravity_scale = 0
		look_at(player_position)
	else:
		
		linear_velocity = Vector2.ZERO
		look_at(player_position)
		gravity_scale = 0



func _on_area_2d_body_entered(body):
	if body.is_in_group("player"):
		body.damage()
		body.damage()
		body.damage()
		body.damage()
		body.damage()
		#im so tired of this
		die()
	pass # Replace with function body.


