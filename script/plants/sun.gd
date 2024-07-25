extends Area2D

var end_y
var move_to_score = false
# 是否按照函数来运行
var function_path = false
# 控制函数正负性
var zf
@onready var tween = create_tween()


func function(x):
	# 二次函数，模拟路径
	return ((x - zf * 6) ** 2) - 40


# Called when the node enters the scene tree for the first time.
func _ready():
	if randi() % 2:
		zf = 1
	else:
		zf = -1


# 从天空中落下的阳光
func init_sky():
	global_position.x = randi_range(200, 1000)
	global_position.y = -20
	end_y = randi_range(100, 550)
	# 创建下落动画
	self.tween.tween_property(self, "global_position:y", end_y, end_y / 100)


func init_sunflower(x, y):
	end_y = y
	function_path = true
	global_position.x = x


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if function_path:
		var vel = Vector2(zf, 0)
		position += vel.normalized() * 15 * delta
		position.y = function(position.x)
		if abs(global_position.y - end_y) < 4:
			function_path = false
	if move_to_score:
		const GOTO_SCORE_SPEED = 500
		var stop = $"/root/main/score".global_position
		global_position = global_position.move_toward(stop, delta * GOTO_SCORE_SPEED)
		if abs(global_position.x - stop.x) < 10 and abs(global_position.y - stop.y) < 10:
			PlantsBarAutoload.sun += PlantsBarAutoload.sun_add_once
			queue_free()


func _on_input_event(_viewport, event, _shape_idx):
	if event is InputEventMouseButton && event.pressed:
		# 移动到计数牌，删除自身
		move_to_score = true
		self.tween.kill()
		function_path = false
		$disappeartimer.stop()


func _on_disappeartimer_timeout():
	queue_free()
