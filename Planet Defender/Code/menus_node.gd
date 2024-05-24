extends Node2D
@export var Level_1 : PackedScene
@export var Level_2 : PackedScene
func _process(_delta):
	pass
# Called when the node enters the scene tree for the first time.
func _ready():
	$BackGround/Main_Menu.show()


func _on_start_pressed():
	$"BackGround/Level Select".show()
	$BackGround/Main_Menu.hide()


func _on_back_pressed():
	$"BackGround/Level Select".hide()
	$BackGround/Main_Menu.show()


func _on_level_1_pressed():
	$"BackGround".hide()
	var L = Level_1.instantiate()
	get_parent().add_child(L)

func _on_level_2_pressed():
	pass


func _on_pause_menu_level_left(_Level_left):
	$"BackGround".show()


func _on_pause_menu_restarted():
	get_parent().get_node("Level 1").show()
