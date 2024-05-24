extends Node2D
var destination
var current_floor
var mid = 0
var floors_up
var floors_down
var panel_button
var waited = false
var queue_destination_down=[]
var queue_destination_up=[]
var queue_pickup_down= []
var queue_pickup_up=[]
var direction
var elevator
var flag = true
var job = true
func _ready():
	#Setting values to each floor so the Elevator knows where it is at all times
	floors_up={get_node('PositionMarkerB2').position.y:$UpB2,get_node('PositionMarkerB1').position.y:$UpB1, get_node("PositionMarker1").position.y:$Up1,get_node("PositionMarker2").position.y:$Up2,get_node("PositionMarker3").position.y:$Up3,get_node("PositionMarker4").position.y:$Up4,
get_node("PositionMarker5").position.y:$Up5,get_node("PositionMarker6").position.y: $Up6,get_node("PositionMarker7").position.y:$Up7,get_node("PositionMarker8").position.y:$Up8,
get_node("PositionMarker9").position.y:$Up9,get_node("PositionMarker10").position.y:$Up10,get_node("PositionMarker11").position.y:$Up11,}
	floors_down={get_node('PositionMarkerB1').position.y:$DownB1,get_node("PositionMarker1").position.y:$Down1,get_node("PositionMarker2").position.y:$Down2,get_node("PositionMarker3").position.y:$Down3,get_node("PositionMarker4").position.y:$Down4,
get_node("PositionMarker5").position.y:$Down5,get_node("PositionMarker6").position.y: $Down6,get_node("PositionMarker7").position.y:$Down7,get_node("PositionMarker8").position.y:$Down8,
get_node("PositionMarker9").position.y:$Down9,get_node("PositionMarker10").position.y:$Down10,get_node("PositionMarker11").position.y:$Down11,get_node("PositionMarker12").position.y:$Down12}
	panel_button={get_node('PositionMarkerB2').position.y:$"Elevator Panel/Panel/B2", get_node('PositionMarkerB1').position.y:$"Elevator Panel/Panel/B1",get_node("PositionMarker1").position.y:$"Elevator Panel/Panel/1",get_node("PositionMarker2").position.y:$"Elevator Panel/Panel/2",get_node("PositionMarker3").position.y:$"Elevator Panel/Panel/3",get_node("PositionMarker4").position.y:$"Elevator Panel/Panel/4",
get_node("PositionMarker5").position.y:$"Elevator Panel/Panel/5",get_node("PositionMarker6").position.y: $"Elevator Panel/Panel/6",get_node("PositionMarker7").position.y:$"Elevator Panel/Panel/7",get_node("PositionMarker8").position.y:$"Elevator Panel/Panel/8",
get_node("PositionMarker9").position.y:$"Elevator Panel/Panel/9",get_node("PositionMarker10").position.y:$"Elevator Panel/Panel/10",get_node("PositionMarker11").position.y:$"Elevator Panel/Panel/11",get_node("PositionMarker12").position.y:$"Elevator Panel/Panel/12"}
	elevator= get_node('Elevator').position.y
func _process(_delta):
	where_am_I()
	if queue_pickup_down.size() ==0 and queue_destination_down.size()==0 and queue_pickup_up.size() !=0:
		direction = true
	if queue_pickup_up.size() ==0 and queue_destination_up.size()==0 and queue_pickup_down.size() != 0:
		direction = false
	#I check if there is a queue for the elevator if there isn't I stay dormint
	if  queue_pickup_up.size() == 0 and queue_pickup_down.size() == 0 and queue_destination_down.size()== 0 and queue_destination_up.size()==0:
		idle()
	else:
	
	#I sort through the cued elevator code by taking where the elevator is and sorting the list based on the optimal route the elevator should take
		
		if queue_pickup_up.size() !=0 and direction == true and job == true:
				waited = false
				mid=0
				if get_node('Elevator').position.y > queue_pickup_up.max():
					queue_pickup_up.sort()
					queue_pickup_up.reverse()
				if get_node('Elevator').position.y < queue_pickup_up.max():
					queue_pickup_up.sort()
				if queue_pickup_up[0] < get_node("Elevator").position.y:
					get_node("Elevator").position.y-=1
				if queue_pickup_up[0]> get_node("Elevator").position.y:
					get_node("Elevator").position.y+=1
				#Once arrived at the queued pickup location I remove it from the queue and I turn off pressed buttons and I open the doors
				if get_node("Elevator").position.y == queue_pickup_up[0] and flag==true:
					$"Elevator Panel/Panel/Up Arrow".set_pressed(true)
					current_floor=(floors_up[get_node("Elevator").position.y])
					current_floor.set_pressed(false)
					flag=false
					get_node('Elevator').get_node("AnimatedSprite2D").play('Open')
					panel_button[queue_destination_up[0]].set_pressed(true)
					await get_tree().create_timer(2).timeout 
					get_node('Elevator').get_node("AnimatedSprite2D").play('Close')
					await get_tree().create_timer(2).timeout 
					queue_pickup_up.remove_at(0)
					if queue_pickup_up.size() == 0:
						job=false
					flag = true
		# Once all Queued up pickups are done I sort through the destinations list and I find the optimal route to take 
		if queue_destination_up.size() !=0 and job==false and direction== true:
			waited = false
			if get_node('Elevator').position.y > queue_destination_up.max():
				queue_destination_up.sort()
				queue_destination_up.reverse()
			if get_node('Elevator').position.y < queue_destination_up.max():
					queue_destination_up.sort()
			if queue_destination_up[0] < get_node("Elevator").position.y:
					get_node("Elevator").position.y-=1
			if queue_destination_up[0]> get_node("Elevator").position.y:
					get_node("Elevator").position.y+=1
			#Once arrived at the queued destination location I remove it from the queue and I turn off pressed buttons and I open the doors
			if get_node("Elevator").position.y == queue_destination_up[0] and flag==true:
					flag=false
					get_node('Elevator').get_node("AnimatedSprite2D").play('Open')
					panel_button[queue_destination_up[0]].set_pressed(false)
					await get_tree().create_timer(2).timeout 
					get_node('Elevator').get_node("AnimatedSprite2D").play('Close')
					await get_tree().create_timer(2).timeout 
					queue_destination_up.remove_at(0)
					if queue_destination_up.size()== 0:
						$"Elevator Panel/Panel/Up Arrow".set_pressed(false)
						job = true
					flag = true
		#I sort through the cued elevator code by taking where the elevator is and sorting the list based on the optimal route the elevator should take
		if queue_pickup_down.size()!=0 and direction == false and flag == true:
			waited = false
			mid=0
			if get_node('Elevator').position.y > queue_pickup_down.min():
					queue_pickup_down.sort()
			if get_node('Elevator').position.y < queue_pickup_down.min():
				queue_pickup_down.sort()
				queue_pickup_down.reverse()
			if queue_pickup_down[0] < get_node("Elevator").position.y:
					get_node("Elevator").position.y-=1
			if queue_pickup_down[0]> get_node("Elevator").position.y:
					get_node("Elevator").position.y+=1
		# Once all Queued up pickups are done I sort through the destinations list and I find the optimal route to take 
			if get_node("Elevator").position.y == queue_pickup_down[0] and flag==true:
					$"Elevator Panel/Panel/Down Arrow".set_pressed(true)
					for each in queue_destination_down:
						panel_button[each].set_pressed(true)
					current_floor=(floors_down[get_node("Elevator").position.y])
					current_floor.set_pressed(false)
					flag=false
					get_node('Elevator').get_node("AnimatedSprite2D").play('Open')
					await get_tree().create_timer(2).timeout 
					get_node('Elevator').get_node("AnimatedSprite2D").play('Close')
					await get_tree().create_timer(2).timeout 
					queue_pickup_down.remove_at(0)
					if queue_pickup_down.size() == 0:
						job=false
					flag = true
		#
		if queue_destination_down.size() !=0 and job==false and direction== false:
			waited= false
			if get_node('Elevator').position.y > queue_destination_down.max():
				queue_destination_down.sort()
				queue_destination_down.reverse()
			if get_node('Elevator').position.y < queue_destination_down.max():
					queue_destination_down.sort()
			if queue_destination_down[0] < get_node("Elevator").position.y:
				get_node("Elevator").position.y-=1
			if queue_destination_down[0]> get_node("Elevator").position.y:
				get_node("Elevator").position.y+=1
				#Pick Up Code Once Arrived at floor
			if get_node("Elevator").position.y == queue_destination_down[0] and flag==true:
					flag=false
					get_node('Elevator').get_node("AnimatedSprite2D").play('Open')
					panel_button[queue_destination_down[0]].set_pressed(false)
					await get_tree().create_timer(2).timeout 
					get_node('Elevator').get_node("AnimatedSprite2D").play('Close')
					await get_tree().create_timer(2).timeout 
					queue_destination_down.remove_at(0)
					if queue_destination_down.size()== 0:
						$"Elevator Panel/Panel/Down Arrow".set_pressed(false)
						job=true
					flag = true
		#if queue_destination_down.size() !=0 and queue_pickup_up.size() != 0 and job == false and direction == false:
			#if (get_node('Elevator').position.y- queue_destination_down[0]) > (get_node('Elevator').position.y-queue_pickup_down[0]):
					#if get_node("Elevator").position.y == queue_pickup_down[0] and flag==true:
						#flag=false
						#get_node('Elevator').get_node("AnimatedSprite2D").play('Open')
						#await get_tree().create_timer(2).timeout 
						#get_node('Elevator').get_node("AnimatedSprite2D").play('Close')
						#await get_tree().create_timer(2).timeout 
						#queue_pickup_down.remove_at(0)
						#if queue_destination_down.size()== 0:
							#job=true
						#flag = true

func _on_up_b_2_pressed():
	queue_pickup_up.insert(queue_pickup_up.size(),get_node("PositionMarkerB2").position.y)
	destination= get_node("PositionMarker"+str((randi() % 11)+1)).position.y
	queue_destination_up.append(destination)
	waited=true
func _on_up_b_1_pressed():
	queue_pickup_up.insert(queue_pickup_up.size(),get_node("PositionMarkerB1").position.y)
	destination= get_node("PositionMarker"+str((randi() % 11)+1)).position.y
	queue_destination_up.append(destination)
	print(queue_destination_up)
	waited=true

func _on_down_b_1_pressed():
	queue_pickup_down.insert(queue_pickup_down.size(),get_node("PositionMarkerB1").position.y)
	destination= get_node("PositionMarkerB2").position.y
	queue_destination_down.append(destination)

func _on_up_1_pressed():
	queue_pickup_up.insert(queue_pickup_up.size(),get_node("PositionMarker1").position.y)
	destination= get_node("PositionMarker"+str((randi() % 10)+2)).position.y
	queue_destination_up.append(destination)
	

func _on_down_1_pressed():
	queue_pickup_down.append(get_node("PositionMarker1").position.y)
	var d = (randi() % 99) +1
	if d <= 50:
		destination= get_node("PositionMarkerB2").position.y
	if  d > 50:
		destination= get_node("PositionMarkerB1").position.y
	queue_destination_down.append(destination)

func _on_up_2_pressed():
	queue_pickup_up.insert(queue_pickup_up.size(),get_node("PositionMarker2").position.y)
	destination= get_node("PositionMarker"+str((randi() % 9)+3)).position.y
	queue_destination_up.append(destination)

func _on_down_2_pressed():
	queue_pickup_down.append(get_node("PositionMarker2").position.y)
	var d = (randi() % 99) +1
	if d <= 30:
		destination= get_node("PositionMarkerB2").position.y
	if  d > 30 and d<60:
		destination= get_node("PositionMarkerB1").position.y
	if d > 60:
		destination= get_node("PositionMarker1").position.y
	queue_destination_down.append(destination)

func _on_up_3_pressed():
	queue_pickup_up.insert(queue_pickup_up.size(),get_node("PositionMarker3").position.y)
	destination= get_node("PositionMarker"+str((randi() % 8)+4)).position.y
	queue_destination_up.append(destination)

func _on_down_3_pressed():
	queue_pickup_down.insert(queue_pickup_down.size(),get_node("PositionMarker3").position.y)
	var d = (randi() % 99) +1
	if d <= 30:
		destination= get_node("PositionMarkerB2").position.y
	if  d > 30 and d<60:
		destination= get_node("PositionMarkerB1").position.y
	if d > 60 and d<90:
		destination= get_node("PositionMarker1").position.y
	if d>90:
		destination= get_node("PositionMarker"+str(randi()%1+1)).position.y
	queue_destination_down.append(destination)

func _on_up_4_pressed():
	queue_pickup_up.insert(queue_pickup_up.size(),get_node("PositionMarker4").position.y)
	destination= get_node("PositionMarker"+str((randi() % 7)+5)).position.y
	queue_destination_up.append(destination)

func _on_down_4_pressed():
	queue_pickup_down.insert(queue_pickup_down.size(),get_node("PositionMarker4").position.y)
	var d = (randi() % 99) +1
	if d <= 30:
		destination= get_node("PositionMarkerB2").position.y
	if  d > 30 and d<60:
		destination= get_node("PositionMarkerB1").position.y
	if d > 60 and d<90:
		destination= get_node("PositionMarker1").position.y
	if d>90:
		destination= get_node("PositionMarker"+str(randi()%2+1)).position.y
	queue_destination_down.append(destination)

func _on_up_5_pressed():
	queue_pickup_up.insert(queue_pickup_up.size(),get_node("PositionMarker5").position.y)
	destination= get_node("PositionMarker"+str((randi() % 4)+6)).position.y
	queue_destination_up.append(destination)

func _on_down_5_pressed():
	queue_pickup_down.insert(queue_pickup_down.size(),get_node("PositionMarker5").position.y)
	var d = (randi() % 99) +1
	if d <= 30:
		destination= get_node("PositionMarkerB2").position.y
	if  d > 30 and d<60:
		destination= get_node("PositionMarkerB1").position.y
	if d > 60 and d<90:
		destination= get_node("PositionMarker1").position.y
	if d>90:
		destination= get_node("PositionMarker"+str(randi()%3+1)).position.y
	queue_destination_down.append(destination)

func _on_up_6_pressed():
	queue_pickup_up.insert(queue_pickup_up.size(),get_node("PositionMarker6").position.y)
	destination= get_node("PositionMarker"+str((randi() % 3)+7)).position.y
	queue_destination_up.append(destination)

func _on_down_6_pressed():
	queue_pickup_down.insert(queue_pickup_down.size(),get_node("PositionMarker6").position.y)
	var d = (randi() % 99) +1
	if d <= 30:
		destination= get_node("PositionMarkerB2").position.y
	if  d > 30 and d<60:
		destination= get_node("PositionMarkerB1").position.y
	if d > 60 and d<90:
		destination= get_node("PositionMarker1").position.y
	if d>90:
		destination= get_node("PositionMarker"+str(randi()%4+1)).position.y
	queue_destination_down.append(destination)

func _on_up_7_pressed():
	queue_pickup_up.insert(queue_pickup_up.size(),get_node("PositionMarker7").position.y)
	destination= get_node("PositionMarker"+str(12-(randi() % 5))).position.y
	queue_destination_up.append(destination)

func _on_down_7_pressed():
	queue_pickup_down.insert(queue_pickup_down.size(),get_node("PositionMarker7").position.y)
	var d = (randi() % 99) +1
	if d <= 30:
		destination= get_node("PositionMarkerB2").position.y
	if  d > 30 and d<60:
		destination= get_node("PositionMarkerB1").position.y
	if d > 60 and d<90:
		destination= get_node("PositionMarker1").position.y
	if d>90:
		destination= get_node("PositionMarker"+str(randi()%5+1)).position.y
	queue_destination_down.append(destination)

func _on_up_8_pressed():
	queue_pickup_up.insert(queue_pickup_up.size(),get_node("PositionMarker8").position.y)
	destination= get_node("PositionMarker"+str((randi() % 3)+9)).position.y
	queue_destination_up.append(destination)

func _on_down_8_pressed():
	queue_pickup_down.insert(queue_pickup_down.size(),get_node("PositionMarker8").position.y)
	var d = (randi() % 99) +1
	if d <= 30:
		destination= get_node("PositionMarkerB2").position.y
	if  d > 30 and d<60:
		destination= get_node("PositionMarkerB1").position.y
	if d > 60 and d<90:
		destination= get_node("PositionMarker1").position.y
	if d>90:
		destination= get_node("PositionMarker"+str(randi()%6+1)).position.y
	queue_destination_down.append(destination)

func _on_up_9_pressed():
	queue_pickup_up.insert(queue_pickup_up.size(),get_node("PositionMarker9").position.y)
	destination= get_node("PositionMarker"+str((randi() % 2)+10)).position.y
	queue_destination_up.append(destination)

func _on_down_9_pressed():
	queue_pickup_down.insert(queue_pickup_down.size(),get_node("PositionMarker9").position.y)
	var d = (randi() % 99) +1
	if d <= 30:
		destination= get_node("PositionMarkerB2").position.y
	if  d > 30 and d<60:
		destination= get_node("PositionMarkerB1").position.y
	if d > 60 and d<90:
		destination= get_node("PositionMarker1").position.y
	if d>90:
		destination= get_node("PositionMarker"+str(randi()%7+1)).position.y
	queue_destination_down.append(destination)

func _on_up_10_pressed():
	queue_pickup_up.insert(queue_pickup_up.size(),get_node("PositionMarker10").position.y)
	destination= get_node("PositionMarker"+str((randi() % 1)+11)).position.y
	queue_destination_up.append(destination)

func _on_down_10_pressed():
	queue_pickup_down.insert(queue_pickup_down.size(),get_node("PositionMarker10").position.y)
	var d = (randi() % 99) +1
	if d <= 30:
		destination= get_node("PositionMarkerB2").position.y
	if  d > 30 and d<60:
		destination= get_node("PositionMarkerB1").position.y
	if d > 60 and d<90:
		destination= get_node("PositionMarker1").position.y
	if d>90:
		destination= get_node("PositionMarker"+str(randi()%8+1)).position.y
	queue_destination_down.append(destination)

func _on_up_11_pressed():
	queue_pickup_up.insert(queue_pickup_up.size(),get_node("PositionMarker11").position.y)
	destination= get_node("PositionMarker12").position.y
	queue_destination_up.append(destination)

func _on_down_11_pressed():
	queue_pickup_down.insert(queue_pickup_down.size(),get_node("PositionMarker11").position.y)
	var d = (randi() % 99) +1
	if d <= 30:
		destination= get_node("PositionMarkerB2").position.y
	if  d > 30 and d<60:
		destination= get_node("PositionMarkerB1").position.y
	if d > 60 and d<90:
		destination= get_node("PositionMarker1").position.y
	if d>90:
		destination= get_node("PositionMarker"+str(randi()%9+1)).position.y
	queue_destination_down.append(destination)

func _on_down_12_pressed():
	queue_pickup_down.insert(queue_pickup_down.size(),get_node("PositionMarker12").position.y)
	var d = (randi() % 99) +1
	if d <= 30:
		destination= get_node("PositionMarkerB2").position.y
	if  d > 30 and d<60:
		destination= get_node("PositionMarkerB1").position.y
	if d > 60 and d<90:
		destination= get_node("PositionMarker1").position.y
	if d>90:
		destination= get_node("PositionMarker"+str(randi()%8+1)).position.y
	queue_destination_down.append(destination)
func where_am_I():
	if get_node("Elevator").position.y == 59:
		$"Elevator Panel/Panel/Current Floor".set_text('12')
	if get_node("PositionMarker11").position.y <  get_node("Elevator").position.y and get_node("PositionMarker10").position.y >  get_node("Elevator").position.y:
		$"Elevator Panel/Panel/Current Floor".set_text('11')
	if get_node("PositionMarker10").position.y <  get_node("Elevator").position.y and get_node("PositionMarker9").position.y >  get_node("Elevator").position.y:
		$"Elevator Panel/Panel/Current Floor".set_text('10')
	if get_node("PositionMarker9").position.y <  get_node("Elevator").position.y and get_node("PositionMarker8").position.y >  get_node("Elevator").position.y:
		$"Elevator Panel/Panel/Current Floor".set_text('9')
	if get_node("PositionMarker8").position.y <  get_node("Elevator").position.y and get_node("PositionMarker7").position.y >  get_node("Elevator").position.y:
		$"Elevator Panel/Panel/Current Floor".set_text('8')
	if get_node("PositionMarker7").position.y <  get_node("Elevator").position.y and get_node("PositionMarker6").position.y >  get_node("Elevator").position.y:
		$"Elevator Panel/Panel/Current Floor".set_text('7')
	if get_node("PositionMarker6").position.y <  get_node("Elevator").position.y and get_node("PositionMarker5").position.y >  get_node("Elevator").position.y:
		$"Elevator Panel/Panel/Current Floor".set_text('6')
	if get_node("PositionMarker5").position.y <  get_node("Elevator").position.y and get_node("PositionMarker4").position.y >  get_node("Elevator").position.y:
		$"Elevator Panel/Panel/Current Floor".set_text('5')
	if get_node("PositionMarker4").position.y <  get_node("Elevator").position.y and get_node("PositionMarker3").position.y >  get_node("Elevator").position.y:
		$"Elevator Panel/Panel/Current Floor".set_text('4')
	if get_node("PositionMarker3").position.y <  get_node("Elevator").position.y and get_node("PositionMarker2").position.y >  get_node("Elevator").position.y:
		$"Elevator Panel/Panel/Current Floor".set_text('3')
	if get_node("PositionMarker2").position.y <  get_node("Elevator").position.y and get_node("PositionMarker1").position.y >  get_node("Elevator").position.y:
		$"Elevator Panel/Panel/Current Floor".set_text('2')
	if get_node("PositionMarker1").position.y <  get_node("Elevator").position.y and get_node("PositionMarkerB1").position.y >  get_node("Elevator").position.y:
		$"Elevator Panel/Panel/Current Floor".set_text('1')
	if get_node("PositionMarkerB1").position.y <  get_node("Elevator").position.y and get_node("PositionMarkerB2").position.y >  get_node("Elevator").position.y:
		$"Elevator Panel/Panel/Current Floor".set_text('B1')
	if get_node("PositionMarkerB2").position.y ==  get_node("Elevator").position.y:
		$"Elevator Panel/Panel/Current Floor".set_text('B2')



func _on_hold_toggled(toggled_on):
	if toggled_on == false:
		set_process(true)
	else:
		set_process(false)
func idle():
	await get_tree().create_timer(20).timeout
	if  queue_pickup_up.size() == 0 and queue_pickup_down.size() == 0 and queue_destination_down.size()== 0 and queue_destination_up.size()==0 and get_node('Elevator').position.y > get_node('PositionMarker1').position.y:
		get_node('Elevator').position.y-=1
	if  queue_pickup_up.size() == 0 and queue_pickup_down.size() == 0 and queue_destination_down.size()== 0 and queue_destination_up.size()==0 and get_node('Elevator').position.y < get_node('PositionMarker1').position.y:\
		get_node('Elevator').position.y+=1
