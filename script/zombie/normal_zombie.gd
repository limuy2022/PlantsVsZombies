extends Area2D

var speed = 20
var health = 100
var played = false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func init():
	global_position.x= 1160
	var choose_y = randi_range(0, 4)
	global_position.y = PlantsBarAutoload.grassy[choose_y] - 20
	PlantsBarAutoload.zombie_number[choose_y] += 1

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if health <= 0:
		if played:
			return
		$delete_timer.start()
		$AnimatedSprite2D.play("die")
		played = true
		return
	var vel = Vector2(-1, 0)
	position += vel.normalized() * speed * delta

func _on_delete_timer_timeout():
	queue_free()
