extends Control
class_name Upgrades
signal speedd
signal boost
signal shield
signal Bullet_Speed
signal Auto_Bullet
signal bsize
signal Cash
signal Shockwave
signal bomb
var player
# Called when the node enters the scene tree for the first time.
func _ready():
	$Panel/Boost_Upgrade.hide()
	$Panel/Shield_Upgrade.hide()
	$Panel/Bullet_Speed_Upgrade.hide()
	$Panel/Shockwave_Upgrade.hide()
	$Panel/Bullet_Size_Upgrade.hide()
	$Panel/Bomb_Upgrade.hide()
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	player = get_parent().get_parent().get_node("Mouse_Moved_Player")
func _on_speed_upgrade_pressed():
	if player.coins >= 5:
		player.remove_coins(5)
		$Panel/Boost_Upgrade.show()
		$Panel/Ship_Upgrade_Tree_Line.add_point(Vector2(-100,40), 1)
		emit_signal('speedd',speedd)
	


func _on_boost_upgrade_pressed():
	if player.coins >= 10:
		player.remove_coins(10)
		$Panel/Shield_Upgrade.show()
		$Panel/Ship_Upgrade_Tree_Line.add_point(Vector2(-15,-5),2)
		emit_signal('boost',boost)

func _on_shield_upgrade_pressed():
	if player.coins >= 15:
		player.remove_coins(15)
		$Panel/Ship_Upgrade_Tree_Line.add_point(Vector2(-100,-15),3)
		emit_signal('shield',shield)

func _on_automatic_upgrade_pressed():
	if player.coins >= 5:
		player.remove_coins(5)
		$Panel/Bullet_Speed_Upgrade.show()
		$Panel/Weaponry_Upgrade_Tree_Line.add_point(Vector2(430,-450),1)
		emit_signal('Auto_Bullet',Auto_Bullet)


func _on_bullet_speed_upgrade_pressed():
	if player.coins >= 10:
		player.remove_coins(10)
		$Panel/Bullet_Size_Upgrade.show()
		$Panel/Weaponry_Upgrade_Tree_Line.add_point(Vector2(50,-730),2)
		emit_signal('Bullet_Speed',Bullet_Speed)
func _on_double_cash_upgrade_pressed():
	if player.coins >= 5:
		player.remove_coins(5)
		$Panel/Bomb_Upgrade.show()
		emit_signal("Cash",Cash)
		$Panel/Misc_Upgrade_Tree_Line.add_point(Vector2(1600,-450),1)
func _on_bomb_upgrade_pressed():
	if player.coins >= 10:
		player.remove_coins(10)
		$Panel/Shockwave_Upgrade.show()
		emit_signal("bomb",bomb)
		$Panel/Misc_Upgrade_Tree_Line.add_point(Vector2(1250,-730),2)
func _on_shockwave_upgrade_pressed():
	if player.coins >= 15:
		player.remove_coins(15)
		emit_signal("Shockwave",Shockwave)
		$Panel/Misc_Upgrade_Tree_Line.add_point(Vector2(1600,-830),3)
func _on_bullet_size_upgrade_pressed():
	if player.coins >= 15:
		player.remove_coins(15)
		emit_signal("bsize",bsize)
		$Panel/Weaponry_Upgrade_Tree_Line.add_point(Vector2(460,-900),3)
