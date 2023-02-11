extends Area2D

var speed = 400
var boom = preload("res://resources/graphics/Bullets/PeaNormalExplode/PeaNormalExplode_0.png")
var stop = false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass
	
func init(x, y):
	global_position.x = PlantsBarAutoload.grassx[x]
	global_position.y = PlantsBarAutoload.grassy[y] - 18

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if stop:
		return
	var vel = Vector2(1, 0)
	position += vel.normalized() * speed * delta

func _on_area_entered(area):
	$Sprite2D.texture = boom
	$delete_timer.start()
	stop = true
	area.be_attacked(20)

func _on_delete_timer_timeout():
	queue_free()
