extends "res://script/plants/basic.gd"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func init(x, y):
	basicinit()
	$AnimatedSprite2D.global_position.x = x
	$AnimatedSprite2D.global_position.y = y

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_sleeptimer_timeout():
	$AnimatedSprite2D.play("can_be_used")
