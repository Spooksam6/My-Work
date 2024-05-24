extends CharacterBody2D
var coins = 0
@export var bullet : PackedScene
@export var health = 5
@export var speed = 1000
@export var shockwave : PackedScene
@export var bomb : PackedScene
var boost_factor = 1
var speed_factor = 1
var size_factor = 1
var spedd_factor = 1
var off=false
signal hit
var autofire = false
var has_boost = false
var has_shockwave = false
var has_bomb = false
var coin_factor = 1
func _physics_process(_delta : float) -> void:
	if Input.is_action_pressed("Boost") and has_boost == true:
		has_boost = false
		boost_factor = 5
		$boost_timer.start()
	if Input.is_action_pressed("bomb") and has_bomb == true:
		print('bombed')
		var bm = bomb.instantiate()
		bm.speed += sqrt(abs(velocity.x)+abs(velocity.y))*50*speed_factor
		get_parent().add_child(bm)
		bm.transform = $"Aiming Direction/Animations/Muzzle".global_transform
		has_bomb = false
		$bomb_timer.start()
	if Input.is_action_pressed("shock") and has_shockwave == true:
		var s = shockwave.instantiate()
		s.speed += sqrt(abs(velocity.x)+abs(velocity.y))*50*speed_factor
		get_parent().add_child(s)
		s.transform = $"Aiming Direction/Animations/Muzzle".global_transform
		has_shockwave = false
		$shockwave_timer.start()
	if Input.is_action_just_pressed("shoot") and autofire == false:
		shoot()
	if Input.is_action_pressed("move") and off == false:
		var vel : Vector2 = (get_global_mouse_position()- global_position).normalized()*speed*boost_factor*spedd_factor
		velocity = vel
		$"Aiming Direction/Animations".play("flying")
		move_and_slide()
		if position.x < 0:
			position.x = 0
		if position.y < 0:
			position.y = 0
		if position.x > 4164:
			position.x = 4164
		if position.y > 2560:
			position.y = 2560
func die():
	get_parent().get_node("wave").queue_free()
	$"Aiming Direction/Animations".play("die")
	$game_over_timer.start()
func damage():
	emit_signal("hit", hit)
func shoot():
	var b = bullet.instantiate()
	b.transform = $"Aiming Direction/Animations/Muzzle".global_transform
	b.speed += sqrt(abs(velocity.x)+abs(velocity.y))*50*speed_factor
	b.scale = (b.scale * size_factor)
	get_parent().add_child(b)
func _on_player_upgrade_menu_auto_bullet(_bullet):
	$shoottimer.start()

	pass # Replace with function body.


func _on_shoottimer_timeout():
	if Input.is_action_pressed("shoot"):
		shoot()
func add_coins(x):
	coins += (x*coin_factor)
	get_node("hud_canvas").get_node("HUD").get_node("Coin_Count").text = "Coins:" + str(coins)
func remove_coins(x):
	coins -= x
	get_node("hud_canvas").get_node("HUD").get_node("Coin_Count").text = "Coins:" + str(coins)
func _on_player_upgrade_menu_boost(_boost):
	has_boost = true
func _on_new_boost_timer_timeout():
	has_boost = true
func _on_boost_timer_timeout():
	boost_factor = 1
	$"Aiming Direction/Animations".play("boost")
	$new_boost_timer.start()

func _on_player_upgrade_menu_cash(_Cash):
	print("ran")
	coin_factor = 2


func _on_player_upgrade_menu_bullet_speed(_Bullet_Speed):
	speed_factor = 2


func _on_player_upgrade_menu_shockwave(_Shockwave):
	has_shockwave = true
	pass # Replace with function body.


func _on_shockwave_timer_timeout():
	has_shockwave = true


func _on_player_upgrade_menu_bsize(_bsize):
	size_factor = 2
	pass # Replace with function body.

func _on_player_upgrade_menu_bomb(_bomb):
	has_bomb = true
	pass # Replace with function body.


func _on_bomb_timer_timeout():
	has_bomb = true
	pass # Replace with function body.


func _on_player_upgrade_menu_speedd(_speedd):
	spedd_factor = 1.5


func _on_node_2d_disable(_disable):
	$"Aiming Direction/Animations".play('Death')
	off=true


func _on_node_2d_enable(_enable):
	$"Aiming Direction/Animations".play('flying')
	off=true
