extends RigidBody2D
@export var speed = 500
var player_position
var target_position
var timer = 0
@onready var player = get_parent().get_node("Mouse_Moved_Player")
@export var mob : PackedScene
func _ready():
	$AnimatedSprite2D.play()
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


func _on_gel_body_entered(body):
	if body.is_in_group("player"):
		body.damage()
		queue_free()
	pass # Replace with function body.
