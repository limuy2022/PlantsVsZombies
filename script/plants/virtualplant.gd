extends AnimatedSprite2D

var follow = false
var sprite_frames_local

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func init(path, numend):
	sprite_frames_local = SpriteFrames.new()
	for i in range(numend):
		sprite_frames_local.add_frame("default", load(path % i))
	hide()
	$".".sprite_frames = sprite_frames_local
	self.autoplay = "default"

func del():
	sprite_frames_local.free()
	queue_free()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if follow:
		# 一直跟随鼠标
		global_position = get_viewport().get_mouse_position()
		# 找到自己最接近哪个区域
		var x
		var xmin = 1e8
		var y
		var ymin = 1e8
		for i in range(0, len(PlantsBarAutoload.grassx)):
			var tmp = abs(position.x - PlantsBarAutoload.grassx[i])
			if tmp < xmin:
				xmin = tmp
				x = i
		for i in range(0, len(PlantsBarAutoload.grassy)):
			var tmp = abs(position.y - PlantsBarAutoload.grassy[i])
			if tmp < ymin:
				ymin = tmp
				y = i
