extends "res://script/plants/basic.gd"

var sun_scene = preload("res://scene/plants/sun.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func init(x, y):
	basicinit()
	global_position.x = PlantsBarAutoload.grassx[x]
	global_position.y = PlantsBarAutoload.grassy[y]
	xpos = x
	ypos = y

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_timer_timeout():
	$Timer.wait_time = randi_range(8, 12)
	var sun = sun_scene.instantiate()
	add_child(sun)
	sun.init_sunflower(global_position.x, global_position.y)
