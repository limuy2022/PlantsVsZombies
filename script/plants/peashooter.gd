extends "res://script/plants/basic.gd"

var bullet_scene = preload("res://scene/plants/bullets/normal_bullet.tscn")
var health = 60


# Called when the node enters the scene tree for the first time.
func _ready():
	pass


func init(x, y):
	basicinit()
	global_position.x = PlantsBarAutoload.grassx[x]
	global_position.y = PlantsBarAutoload.grassy[y]
	xpos = x
	ypos = y


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if health <= 0:
		queue_free()


func _on_attack_timer_timeout():
	if PlantsBarAutoload.zombie_number[ypos]:
		var bullet = bullet_scene.instantiate()
		add_child(bullet)
		bullet.init(xpos, ypos)
