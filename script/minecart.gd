extends Area2D

var run = false
var speed = 350

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func init(y):
	global_position.x = 230
	global_position.y = PlantsBarAutoload.grassy[y]

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if run:
		var vel = Vector2(1, 0)
		position += vel.normalized() * delta * speed
		if position.x > 1200:
			queue_free()

func _on_area_entered(area):
	run = true
