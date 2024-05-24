extends RigidBody2D
@export var Bullet : PackedScene

# Called when the node enters the scene tree for the first time.
func _ready():
	
	$AnimatedSprite2D.play()
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	
	if Input.is_action_just_pressed("shoot"):
		shoot()

func shoot():
	var b = Bullet.instantiate()
	add_child(b)
	b.transform = $Muzzle.transform
	




func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()
	pass # Replace with function body.
