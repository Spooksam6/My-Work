extends Area2D
class_name Tower
signal interacted
var interaction_range = false
@export var Basic_Tower : UpgradeMenu
@export var shooter_turret : PackedScene
@export var bomber_turret: PackedScene
@export var waver_turret: PackedScene
signal moved_away
var tower = null
func _ready():
	$Interact_Sign.hide()
	$Label.hide()
func _process(_delta):
	if Input.is_action_just_pressed("interact"):
		if interaction_range:
			emit_signal("interacted", interacted)
func _on_interaction_range_body_entered(body):
	if body.is_in_group("player"): 
		$Interact_Sign.show()
		$Label.show()
		interaction_range = true
func _on_interaction_range_body_exited(body):
	if body.is_in_group("player"): 
		$Interact_Sign.hide()
		$Label.hide()
		interaction_range = false
		emit_signal("moved_away", moved_away)
func on_shooter_1_pressed():
	if not tower:
		if get_parent().get_node("Mouse_Moved_Player").coins >= 5:
			get_parent().get_node("Mouse_Moved_Player").remove_coins(5)
			tower = "shooter_1"
			var st = shooter_turret.instantiate()
			owner.add_child(st)
			st.transform = $AnimatedSprite2D/turret_location.global_transform
func on_shooter_2_pressed():
	if tower == "shooter_1":
		if get_parent().get_node("Mouse_Moved_Player").coins >= 10:
			get_parent().get_node("Mouse_Moved_Player").remove_coins(10)
			$TowerLevel2Badge.show()
			tower = "shooter_2"
func on_shooter_3_pressed():
	if tower == "shooter_2":
		if get_parent().get_node("Mouse_Moved_Player").coins >= 15:
			get_parent().get_node("Mouse_Moved_Player").remove_coins(15)
			$TowerLevel3Badge.show()
			tower = "shooter_3"
func on_bomber_1_pressed():
	if not tower:
		if get_parent().get_node("Mouse_Moved_Player").coins >= 5:
			get_parent().get_node("Mouse_Moved_Player").remove_coins(5)
			tower = "bomber_1"
			var bt = bomber_turret.instantiate()
			owner.add_child(bt)
			bt.transform = $AnimatedSprite2D/turret_location.global_transform	
func on_bomber_2_pressed():
	if tower == "bomber_1":
		if get_parent().get_node("Mouse_Moved_Player").coins >= 10:
			get_parent().get_node("Mouse_Moved_Player").remove_coins(10)
			$TowerLevel2Badge.show()
			tower = "bomber_2"
func on_bomber_3_pressed():
	if tower == "bomber_2":
		if get_parent().get_node("Mouse_Moved_Player").coins >= 15:
			get_parent().get_node("Mouse_Moved_Player").remove_coins(15)
			$TowerLevel3Badge.show()
			tower = "bomber_3"		
func on_waver_1_pressed():
	if not tower:
		if get_parent().get_node("Mouse_Moved_Player").coins >= 5:
			get_parent().get_node("Mouse_Moved_Player").remove_coins(5)
			tower = "waver_1"
			var wt = waver_turret.instantiate()
			owner.add_child(wt)
			wt.transform = $AnimatedSprite2D/turret_location.global_transform	
func on_waver_2_pressed():
	if tower == "waver_1":
		if get_parent().get_node("Mouse_Moved_Player").coins >= 10:
			get_parent().get_node("Mouse_Moved_Player").remove_coins(10)
			$TowerLevel2Badge.show()
			tower = "waver_2"
func on_waver_3_pressed():
	if tower == "waver_2":
		if get_parent().get_node("Mouse_Moved_Player").coins >= 15:
			get_parent().get_node("Mouse_Moved_Player").remove_coins(15)
			$TowerLevel2Badge.hide()
			$TowerLevel3Badge.show()
			tower = "waver_3"		
