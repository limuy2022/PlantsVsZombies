extends Node2D

var stage_num

# Called when the node enters the scene tree for the first time.
func _ready():
	var file = FileAccess.open("res://gamedata/index", FileAccess.READ)
	stage_num = file.get_32()
	var stagefile = FileAccess.open("res://gamedata/stage%s" % stage_num, FileAccess.READ)
	var bgimage_index = stagefile.get_32()
	$background.set_texture(load("res://resources/graphics/Items/Background/Background_%s.jpg" % bgimage_index))

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_plants_menu_pack_plants_card():
	get_tree().call_group("plants_card", "show")
