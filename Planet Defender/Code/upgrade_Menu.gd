extends Control
class_name UpgradeMenu
@export var Upgrade_Menu : Tower
signal shooter_1_pressed
# Called when the node enters the scene tree for the first time.
func _ready():
	hide()
	emit_signal("shooter_1_pressed", shooter_1_pressed)
	Upgrade_Menu.connect("interacted", _on_interated)
	Upgrade_Menu.connect("moved_away", _on_moved_away)
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

func _on_interated(interated):
	if(interated):
		show()
func _on_moved_away(moved_away):
	if(moved_away):
		hide()
func _on_button_1_pressed():
	get_parent().get_parent().get_child(6).on_shooter_1_pressed()
func _on_button_2_pressed():
	get_parent().get_parent().get_child(6).on_shooter_2_pressed()
func _on_button_3_pressed():
	get_parent().get_parent().get_child(6).on_shooter_3_pressed()
func _on_button_4_pressed():
	get_parent().get_parent().get_child(6).on_bomber_1_pressed()
func _on_button_5_pressed():
	get_parent().get_parent().get_child(6).on_bomber_2_pressed()
func _on_button_6_pressed():
	get_parent().get_parent().get_child(6).on_bomber_3_pressed()
func _on_button_7_pressed():
	get_parent().get_parent().get_child(6).on_waver_1_pressed()
func _on_button_8_pressed():
	get_parent().get_parent().get_child(6).on_waver_2_pressed()
func _on_button_9_pressed():
	get_parent().get_parent().get_child(6).on_waver_3_pressed()
