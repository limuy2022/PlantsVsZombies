extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	var file = FileAccess.file_exists("res://gamedata/index")
	if not file:
		file = FileAccess.open("res://gamedata/index", FileAccess.WRITE)
		file.store_32(1)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
