extends Area2D

# 是否已经从高空坠落
var has_fallen_down = false
var end_y
var move_to_score = false
# 是否按照函数来运行
var function_path = false
# 控制函数正负性
var zf


func function(x):
	# 二次函数，模拟路径
	return ((x - zf * 6) ** 2) - 40


# Called when the node enters the scene tree for the first time.
func _ready():
	if randi() % 2:
		zf = 1
	else:
		zf = -1


func init_sky():
	has_fallen_down = false
	global_position.x = randi_range(200, 1000)
	global_position.y = -20
	end_y = randi_range(100, 550)


func init_sunflower(x, y):
	end_y = y
	has_fallen_down = true
	function_path = true
	global_position.x = x


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if not has_fallen_down:
		# 没落地需要先落地
		var vel = Vector2(0, 1)
		const FALL_DOWN_SPEED = 100
		global_position += vel.normalized() * FALL_DOWN_SPEED * delta
		if abs(global_position.y - end_y) < 10:
			has_fallen_down = true
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
		has_fallen_down = true
		function_path = false
		$disappeartimer.stop()


func _on_disappeartimer_timeout():
	queue_free()
