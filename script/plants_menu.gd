extends TextureRect

var speed = 650
var end_index = 98


# Called when the node enters the scene tree for the first time.
func _ready():
	pass  # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if position.y < end_index:
		return
	var p = Vector2(0, -1)
	p = p.normalized() * speed
	position += p * delta
	get_tree().call_group("plants_card", "move_up", delta, speed)
	if position.y < end_index:
		get_tree().call_group("plants_card", "set_pos")
