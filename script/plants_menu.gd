extends TextureRect

var end_index = 518
var origin_pos
var prev_pos = 0

func move_up(up_delta:int):
	self.position.y = origin_pos - up_delta
	get_tree().call_group("plants_card", "move_up", up_delta - self.prev_pos)
	self.prev_pos = up_delta

# Called when the node enters the scene tree for the first time.
func _ready():
	origin_pos = self.position.y
	var tween = create_tween()
	tween.tween_method(move_up, 0, end_index, 1.2)
	tween.tween_callback(func():get_tree().call_group("plants_card", "set_pos"))
