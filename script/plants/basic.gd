extends Area2D

var xpos
var ypos

# Called when the node enters the scene tree for the first time.
func _ready():
	add_to_group("plants")
	
func basicinit():
	show()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
