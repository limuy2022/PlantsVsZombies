extends Control

@export var main_scene: PackedScene
@export var about_scene: PackedScene


# Called when the node enters the scene tree for the first time.
func _ready():
	var file = FileAccess.file_exists("res://gamedata/index")
	if not file:
		file = FileAccess.open("res://gamedata/index", FileAccess.WRITE)
		file.store_32(1)


func _on_startgame_pressed():
	get_tree().change_scene_to_packed(main_scene)


func _on_about_pressed():
	get_tree().change_scene_to_packed(about_scene)
