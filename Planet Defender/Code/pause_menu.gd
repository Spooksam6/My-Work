extends Control

@export var game_manager : GameManager
signal Restarted
signal Level_left
func _ready():
	hide()
	if game_manager!=null:
		game_manager.connect("toggle_game_paused", _on_game_manager_toggle_game_paused)
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

func _on_game_manager_toggle_game_paused(is_paused : bool):
	if(is_paused):
		show()
	else:
		hide()

func _on_quit_button_pressed():
	get_parent().get_parent().get_node("menus_node").queue_free()
	game_manager.game_paused=false
	hide()
	get_parent().get_parent().get_node('Menus node').show()
	emit_signal("Level_left", Level_left)


func _on_player_upgrade_menu_pressed():
	pass
