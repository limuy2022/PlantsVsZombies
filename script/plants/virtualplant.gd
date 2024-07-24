extends Area2D

signal plant_myself
var sprite_frames_local
var pack = false
var follow = false


func init(path, numend):
	sprite_frames_local = SpriteFrames.new()
	for i in range(numend):
		sprite_frames_local.add_frame("default", load(path % i))
	hide()
	sprite_frames_local.set_animation_speed("default", 8)
	$"AnimatedSprite2D".sprite_frames = sprite_frames_local
	$"AnimatedSprite2D".autoplay = "default"


func del():
	sprite_frames_local.free()
	queue_free()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if pack:
		var pos = get_viewport().get_mouse_position()
		var tmp = PlantsBarAutoload.turn_pos_to_grass(pos.x, pos.y)
		if PlantsBarAutoload.has_planted[tmp[0]][tmp[1]]:
			hide()
		else:
			show()
			global_position.x = PlantsBarAutoload.grassx[tmp[0]]
			global_position.y = PlantsBarAutoload.grassy[tmp[1]]
	if follow:
		global_position = get_viewport().get_mouse_position()


func _on_input_event(_viewport, event, _shape_idx):
	# 种植植物
	if event is InputEventMouseButton && event.pressed:
		var pos = get_viewport().get_mouse_position()
		var tmp = PlantsBarAutoload.turn_pos_to_grass(pos.x, pos.y)
		if PlantsBarAutoload.has_planted[tmp[0]][tmp[1]]:
			return
		emit_signal("plant_myself")
