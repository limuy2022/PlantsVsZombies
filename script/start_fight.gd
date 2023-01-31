extends TextureButton

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if PlantsBarAutoload.startfight:
		return
	if PlantsBarAutoload.choose == PlantsBarAutoload.maxnum:
		show()
	else:
		hide()

func _on_pressed():
	hide()
	PlantsBarAutoload.startfight = true
	$"../plants_menu".hide()
	$"../sumtimer".start()
	get_tree().call_group("plants_card", "start_to_fight")
