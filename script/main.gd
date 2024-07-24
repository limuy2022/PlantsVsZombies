extends Node2D


class PlantsData:
	var x_pos: int
	var y_pos: int
	var card_icon: String
	var tscn: PackedScene
	var cost: int
	var cd: int
	var res_path: String
	var res_nums: int


var stage_num
var card = preload("res://scene/card.tscn")
var sun_scene = preload("res://scene/plants/sun.tscn")
var zombie_scene = [preload("res://scene/zombie/normal_zombie.tscn")]
@onready var card_pos: Array[PlantsData] = init_plants_list()


func new_plants_data(
	x_pos: int,
	y_pos: int,
	card_icon: String,
	tscn: PackedScene,
	cost: int,
	cd: int,
	res_path: String,
	res_nums: int
) -> PlantsData:
	var data = PlantsData.new()
	data.x_pos = x_pos
	data.y_pos = y_pos
	data.card_icon = card_icon
	data.tscn = tscn
	data.cost = cost
	data.res_path = res_path
	data.cd = cd
	data.res_nums = res_nums
	return data


func init_plants_list() -> Array[PlantsData]:
	return [
		new_plants_data(
			24,
			645,
			"card_peashooter.png",
			preload("res://scene/plants/peashooter.tscn"),
			100,
			1,
			"PeaShooter/PeaShooter_%s.png",
			25
		),
		new_plants_data(
			81,
			645,
			"card_sunflower.png",
			preload("res://scene/plants/sunflower.tscn"),
			50,
			3,
			"SunFlower/SunFlower_%s.png",
			18
		),
		new_plants_data(
			136,
			645,
			"card_puffshroom.png",
			preload("res://scene/plants/puffshroom.tscn"),
			0,
			7,
			"PuffShroom/PuffShroom/PuffShroom_%s.png",
			14
		),
		new_plants_data(
			191,
			645,
			"card_repeaterpea.png",
			preload("res://scene/plants/repeaterpea.tscn"),
			200,
			6,
			"RepeaterPea/RepeaterPea_%s.png",
			15
		),
		new_plants_data(
			246,
			645,
			"card_spikeweed.png",
			preload("res://scene/plants/spikeweed.tscn"),
			100,
			6,
			"Spikeweed/Spikeweed/Spikeweed_%s.png",
			19
		),
		new_plants_data(
			297,
			645,
			"card_snowpea.png",
			preload("res://scene/plants/snowpea.tscn"),
			175,
			7,
			"SnowPea/SnowPea_%s.png",
			15
		),
		new_plants_data(
			352,
			645,
			"card_scaredyshroom.png",
			preload("res://scene/plants/scaredyshroom.tscn"),
			25,
			5,
			"ScaredyShroom/ScaredyShroom/ScaredyShroom_%s.png",
			17
		),
		new_plants_data(
			410,
			645,
			"card_potatomine.png",
			preload("res://scene/plants/potatomine.tscn"),
			25,
			10,
			"PotatoMine/PotatoMine/PotatoMine_%s.png",
			8
		)
	]


# Called when the node enters the scene tree for the first time.
func _ready():
	var file = FileAccess.open("res://gamedata/index", FileAccess.READ)
	stage_num = file.get_32()
	var stagefile = FileAccess.open("res://gamedata/stage%s" % stage_num, FileAccess.READ)
	var bgimage_index = stagefile.get_32()
	$background.set_texture(
		load("res://resources/graphics/Items/Background/Background_%s.jpg" % bgimage_index)
	)
	for i in card_pos:
		var card_obj = card.instantiate()
		card_obj.init(
			"res://resources/graphics/Cards/" + i.card_icon,
			i.tscn,
			i.cost,
			i.cd,
			"res://resources/graphics/Plants/" + i.res_path,
			i.res_nums
		)
		card_obj.position.x = i.x_pos
		card_obj.position.y = i.y_pos
		add_child(card_obj)


func _on_sumtimer_timeout():
	$suntimer.wait_time = randi_range(7, 10)
	var sun = sun_scene.instantiate()
	add_child(sun)
	sun.init_sky()


func _on_zombie_timer_timeout():
	$zombie_timer.wait_time = randi_range(3, 6)
	var zombie = zombie_scene[randi() % zombie_scene.size()].instantiate()
	add_child(zombie)
	zombie.init()
