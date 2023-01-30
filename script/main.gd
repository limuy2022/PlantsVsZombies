extends Node2D

var stage_num
	
# x坐标，y坐标，卡片图标，对应的植物场景，需要消耗的阳光,cd，[植物图片,图片张数]
const card_pos = [
	[24,645, "card_peashooter.png", "peashooter.tscn", 100, 5, ["Peashooter/Peashooter_%s.png",13]],
	[81,645, "card_sunflower.png", "sunflower.tscn", 50, 5,["SunFlower/SunFlower_%s.png", 18]],
	[136,645, "card_puffshroom.png", "puffshroom.tscn", 0, 7,["PuffShroom/PuffShroom/PuffShroom_%s.png", 14]],
	[191,645, "card_repeaterpea.png", "repeaterpea.tscn", 200, 6, ["RepeaterPea/RepeaterPea_%s.png", 15]],
	[246, 645, "card_spikeweed.png", "spikeweed.tscn", 100, 6, ["Spikeweed/Spikeweed/Spikeweed_%s.png", 19]],
	[297, 645, "card_snowpea.png", "snowpea.tscn", 175, 7, ["SnowPea/SnowPea_%s.png", 15]],
	[352, 645, "card_scaredyshroom.png", "scaredyshroom.tscn", 25, 5, ["ScaredyShroom/ScaredyShroom/ScaredyShroom_%s.png", 17]],
	[410, 645, "card_potatomine.png", "potatomine.tscn", 25, 10, ["PotatoMine/PotatoMine/PotatoMine_%s.png", 8]]
]

var card = preload("res://scene/card.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	var file = FileAccess.open("res://gamedata/index", FileAccess.READ)
	stage_num = file.get_32()
	var stagefile = FileAccess.open("res://gamedata/stage%s" % stage_num, FileAccess.READ)
	var bgimage_index = stagefile.get_32()
	$background.set_texture(load("res://resources/graphics/Items/Background/Background_%s.jpg" % bgimage_index))
	for i in card_pos:
		var card_obj = card.instantiate()
		card_obj.init("res://resources/graphics/Cards/" + i[2], "res://scene/plants/"+i[3], i[4], i[5], "res://resources/graphics/Plants/" + i[6][0], i[6][1])
		card_obj.position.x = i[0]
		card_obj.position.y = i[1]
		add_child(card_obj)
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_sumtimer_timeout():
	pass # Replace with function body.
