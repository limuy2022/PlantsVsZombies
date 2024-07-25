extends Area2D

var end_y
var zf
var vel = Vector2(0.3, -6)
@onready var tween = create_tween()


# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# 从天空中落下的阳光
func init_sky():
	global_position.x = randi_range(200, 1000)
	global_position.y = -20
	end_y = randi_range(100, 550)
	# 创建下落动画
	self.tween.tween_property(self, "global_position:y", end_y, end_y / 100)


func throw():
	self.position.x += vel.x
	self.position.y += vel.y
	vel.y += 0.3
	if self.global_position.y - end_y >= 4 && vel.y > 0:
		self.tween.kill()


func init_sunflower(x, y):
	end_y = y + 40
	global_position.x = x
	zf = 1 if randi() % 2 else -1
	self.vel.x = zf * self.vel.x
	tween = tween.set_loops()
	self.tween.tween_callback(self.throw).set_delay(0.01)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass


func collected_success():
	PlantsBarAutoload.sun += PlantsBarAutoload.sun_add_once
	queue_free()


func _on_input_event(_viewport, event, _shape_idx):
	if event is InputEventMouseButton && event.pressed:
		# 移动到计数牌，删除自身
		self.tween.kill()
		self.tween = create_tween()
		var stop = $"/root/main/score".global_position
		var time = (stop - self.global_position).length() / 500
		self.tween.tween_property(self, "global_position", stop, time)
		self.tween.tween_callback(self.collected_success)
		$disappeartimer.stop()


func _on_disappeartimer_timeout():
	queue_free()
