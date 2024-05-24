extends Area2D
@export var speed = 10
@export var bullet : PackedScene
var direction = Vector2.ZERO
signal bullet_hit
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(_Delta):
	if direction != Vector2.ZERO:
		var velocity = direction * speed
		global_position += velocity
		
func set_direction(direct: Vector2):
	self.direction = direct


func _on_body_entered(body):
	if body.is_in_group("player"):
		body.damage()
		queue_free()
