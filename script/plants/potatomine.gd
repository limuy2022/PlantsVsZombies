extends "res://script/plants/basic.gd"


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


func _on_sleeptimer_timeout():
	$AnimatedSprite2D.play("can_be_used")
