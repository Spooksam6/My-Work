extends RigidBody2D
@export var Bullet : PackedScene
@export var speed = 500
var player_position
var target_position
var timer = 0
@onready var player = get_parent().get_node("Mouse_Moved_Player")
signal mob_fire_bullet(bullet) 
var marked_for_death=false
func _ready():
	$AnimatedSprite2D.play('single_shot_enemy')
	$ShootTimer.start()
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

func shoot(): 
	var b = Bullet.instantiate()
	get_parent().add_child(b)
	b.transform = $AnimatedSprite2D/Muzzle.global_transform
	var direction = (player_position - position).normalized()
	var direction_to_mouse = direction
	b.set_direction(direction_to_mouse)
	emit_signal("mob_fire_bullet", b)



func _on_shoot_timer_timeout():
	shoot()
	pass # Replace with function body.
