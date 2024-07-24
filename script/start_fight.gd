extends TextureButton

var minecart_scene = preload("res://scene/minecart.tscn")


# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if PlantsBarAutoload.startfight:
		return
	if PlantsBarAutoload.choose == PlantsBarAutoload.MAXNUM:
		show()
	else:
		hide()


func _on_pressed():
	hide()
	PlantsBarAutoload.startfight = true
	$"../plants_menu".hide()
	$"../suntimer".start()
	$"../zombie_timer".start()
	get_tree().call_group("plants_card", "start_to_fight")
	# 摆放小推车
	for i in range(5):
		var car_obj = minecart_scene.instantiate()
		$"..".add_child(car_obj)
		car_obj.init(i)
