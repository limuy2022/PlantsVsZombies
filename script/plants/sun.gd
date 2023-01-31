extends Area2D

# 是否已经从高空坠落
var has_fallen_down = false
var end_y
var move_to_score = false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func init_sky():
	has_fallen_down = false
	global_position.x = randi_range(200, 1000)
	global_position.y = -20
	end_y = randi_range(100, 550)
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if not has_fallen_down:
		# 没落地需要先落地
		var vel = Vector2(0, 1)
		const fall_down_speed = 100
		global_position += vel.normalized() * fall_down_speed * delta
		if abs(global_position.y - end_y) < 10:
			has_fallen_down = true
	if move_to_score:
		const goto_score_speed = 500
		var stop = $"../score".global_position
		global_position = global_position.move_toward(stop, delta * goto_score_speed)
		if abs(global_position.x - stop.x) < 10 and abs(global_position.y - stop.y) < 10:
			PlantsBarAutoload.sun += PlantsBarAutoload.sun_add_once
			queue_free()


func _on_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton && event.pressed:
		# 移动到计数牌，删除自身
		move_to_score = true
		has_fallen_down = true
		$disappeartimer.stop()

func _on_disappeartimer_timeout():
	queue_free()
