extends Area2D

var speed = 20
var health = 100
var played = false
var choose_y
var walked = true
# 正在攻击的植物
var attack_plant
# 一次攻击值
const attack_value = 20

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func init():
	global_position.x= 1160
	choose_y = randi_range(0, 4)
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
	if walked:
		var vel = Vector2(-1, 0)
		position += vel.normalized() * speed * delta

func _on_delete_timer_timeout():
	PlantsBarAutoload.zombie_number[choose_y] -= 1
	queue_free()

func _on_area_entered(area):
	if $attack_timer.is_stopped():
		$attack_timer.start()
		$AnimatedSprite2D.play("attack")
		walked = false
		attack_plant = area
		
func _on_area_exited(area):
	$AnimatedSprite2D.play("walk")
	walked = true
	$attack_timer.stop()

func _on_attack_timer_timeout():
	attack_plant.health -= attack_value
