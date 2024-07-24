extends SceneTree


func _init():
	var file = FileAccess.open("stage1", FileAccess.WRITE)
	file.store_32(0)
	print("successful")
	quit()
