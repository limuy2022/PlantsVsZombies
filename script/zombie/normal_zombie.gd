extends Area2D

# 一次攻击值
const ATTACK_VALUE = 20
var speed = 20
var health = 100
var choose_y
# 正在攻击的植物
var attack_plant
var process = walked


# Called when the node enters the scene tree for the first time.
func _ready():
	pass  # Replace with function body.


func init():
	global_position.x = 1160
	choose_y = randi_range(0, 4)
	global_position.y = PlantsBarAutoload.grassy[choose_y] - 20
	PlantsBarAutoload.zombie_number[choose_y] += 1


func del():
	PlantsBarAutoload.zombie_number[choose_y] -= 1
	queue_free()


func walked(delta):
	var vel = Vector2(-1, 0)
	position += vel.normalized() * speed * delta


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if process == null:
		return
	process.call(delta)


func be_attacked(sub):
	if health <= 0:
		return
	health -= sub
	if health <= 0:
		$AnimatedSprite2D.play("die")
		$AnimatedSprite2D.animation_looped.connect(del)
		process = null


func _on_area_entered(area):
	if $attack_timer.is_stopped():
		$attack_timer.start()
		$AnimatedSprite2D.play("attack")
		process = null
		attack_plant = area


func _on_area_exited(_area):
	$AnimatedSprite2D.play("walk")
	process = walked
	$attack_timer.stop()


func _on_attack_timer_timeout():
	attack_plant.health -= ATTACK_VALUE
