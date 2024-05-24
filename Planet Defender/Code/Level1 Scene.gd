extends Node2D
@export var mob_scene: PackedScene
@export var tower : Tower
@export var Level_1 :PackedScene

var amount_mobs = 12
# Called when the node enters the scene tree for the first time.
func _ready():
	
	process_mode = Node.PROCESS_MODE_PAUSABLE
	$MobTimer.start()
	#if $Mouse_Moved_Player/CanvasLayer3 != null:
		#$Mouse_Moved_Player/CanvasLayer3.show()


# Called every frame. 'delta' is the elapsed time since the previous frame.

func _input(event: InputEvent):
	if event.is_action_pressed('upgrade'):
		$CanvasLayer2.visible = !$CanvasLayer2.visible
func _on_mob_timer_timeout():
	if amount_mobs > 0: 
		var mob = mob_scene.instantiate()
		var mob_spawn_location = $MobPath/MobSpawnLocation
		mob_spawn_location.progress_ratio = randf()
		var direction = mob_spawn_location.rotation + PI/2
		
		mob.position = mob_spawn_location.position
		direction += randf_range(-PI/4, PI/4)
		mob.rotation = direction
		
		add_child(mob)
		amount_mobs -= 1
		print(amount_mobs)
	pass # Replace with function body.


func _on_hud_game_over(_game_over):
	$Mouse_Moved_Player/hud_canvas.hide()
	$CanvasLayer4.show()


func _on_game_over_restart(_restart):
	var L = Level_1.instantiate()
	get_parent().add_child(L)


func _on_game_over_quit(_quit):
	queue_free()
	get_parent().get_node("Menus node").get_node("BackGround").show()


func _on_player_upgrade_menu_bsize():
	pass # Replace with function body.
