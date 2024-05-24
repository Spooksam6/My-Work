extends RigidBody2D

@export var speed = 1000
var velocity = Vector2.ZERO
var player 
# Called when the node enters the scene tree for the first time.
func _ready():
	player = get_tree().get_root().get_node("player.tscn")
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	#velocity = position.direction_to(player.position) * speed
	pass
