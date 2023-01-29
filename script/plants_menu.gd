extends TextureRect

signal pack_plants_card

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if(position.y < 100):
		return
	var p = Vector2(0, -1)
	p = p.normalized() * 650
	position += p * delta
	if position.y < 100:
		emit_signal("pack_plants_card")
