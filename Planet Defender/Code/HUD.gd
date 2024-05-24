extends Control
var coins = 0
signal game_over
@export var bullet :bulleted
# Called when the node enters the scene tree for the first time.
func _ready():
	#if bullet != null:
		#bullet.connect("add_coin", add_coins)
	$"Health Bar".show_percentage=false
	$"Health Bar".fill_mode=(0)
	$"Shield Bar".show_percentage=false
	$"Health Bar".value=100

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass


func _on_mouse_moved_player_hit(_hit):
	if $"Shield Bar".value>0:
		$"Shield Bar".value-=5
	else:
		$"Health Bar".value-=5
	if $'Health Bar'.value == 0:
		emit_signal('game_over',game_over)


func _on_player_upgrade_menu_shield(_shield):
	$"Shield Bar".value= 100
	$shield_regen_timer.start()
func _on_shield_regen_timer_timeout():
	if $"Shield Bar".value < 100:
		$"Shield Bar".value +=1
	pass # Replace with function body.

