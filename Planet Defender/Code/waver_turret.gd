extends Area2D
# Called when the node enters the scene tree for the first time.
@export var shockwave : PackedScene
var target
var found_mob = false
var cc
var mob_pos = Vector2.ZERO
var level = 1
var bscale = 1
var tspeed = 6
var btower 
func _ready():
	print("ready worked")
	$shoot_timer.start()
func _process(_delta):
	pass
func aim():
	cc = get_parent().get_child_count()
	found_mob = false
	mob_pos = Vector2.ZERO
	for i in range(0,cc):
		target = get_parent().get_child(i)
		if target.is_in_group("mobs") and found_mob == false:
			found_mob = true
			mob_pos = self.position-target.position
	look_at(mob_pos)
func shoot():
	print('yeah')
	var s = shockwave.instantiate()
	get_parent().add_child(s)
	s.transform = $sprite/turret_muzzle.global_transform
	s.rotation = atan2(-mob_pos.y,-mob_pos.x)
	s.scale = Vector2(bscale,bscale)
func upgrade():
	btower = get_parent().get_child(6)
	if btower.tower == "waver_1":
		level = 1
	if btower.tower == "waver_2":
		level = 2
		bscale = 1.5
		tspeed = 5
	if btower.tower == "waver_3":
		level = 3
		bscale = 2
		tspeed = 3.5
	$shoot_timer.wait_time = tspeed
func _on_shoot_timer_timeout():
	aim()
	upgrade()
	if found_mob == true:
		shoot()
