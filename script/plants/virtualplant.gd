extends Area2D

var sprite_frames_local
var pack = false
signal plant_myself

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

func init(path, numend):
	sprite_frames_local = SpriteFrames.new()
	for i in range(numend):
		sprite_frames_local.add_frame("default", load(path % i))
	hide()
	$"AnimatedSprite2D".sprite_frames = sprite_frames_local
	$"AnimatedSprite2D".autoplay = "default"

func del():
	sprite_frames_local.free()
	queue_free()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if pack:
		var pos = get_viewport().get_mouse_position()
		var tmp = PlantsBarAutoload.turn_pos_to_grass(pos.x, pos.y)
		global_position.x = PlantsBarAutoload.grassx[tmp[0]]
		global_position.y = PlantsBarAutoload.grassy[tmp[1]]


func _on_input_event(viewport, event, shape_idx):
	# 种植植物
	if event is InputEventMouseButton && event.pressed:
		emit_signal("plant_myself")
