extends TextureButton

var has_chosen = false
# 在选择板上的坐标
var on_board_pos
# 在选择板上的索引
var board_index
# 自己对应的植物
var plant_scene:PackedScene
# 是否正在放置植物
var is_finding = false
# 现在控制的植物
var plant
# 种植需要耗费的阳光
var value
# CD时间
var CDtime
# 是否可以种植
var canplant = true
# 植物虚影场景
var virtual_plant_scene = preload("res://scene/plants/virtualplant.tscn")
# 植物虚影
var virtual_plant

func init(card_image_path, plants_scene, sunvalue, CDtime_, respath, image_num):
	scale.x = 0.8
	scale.y = 0.8
	texture_normal = load(card_image_path)
	plant_scene = load(plants_scene)
	value = sunvalue
	CDtime = CDtime_
	$CD.wait_time = CDtime_
	virtual_plant = virtual_plant_scene.instantiate()
	virtual_plant.init(respath, image_num)
	add_child(virtual_plant)

# Called when the node enters the scene tree for the first time.
func _ready():
	add_to_group("plants_card")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

# 向上移动
func move_up(delta, speed):
	var p = Vector2(0, -1)
	p = p.normalized() * speed
	position += p * delta

func starttimer():
	$CD.start()

# 记录当前坐标	
func set_pos():
	on_board_pos = position
	
func try_to_free():
	# 如果未使用，删除自身
	if not has_chosen:
		virtual_plant.del()
		queue_free()

func _on_pressed():
	if PlantsBarAutoload.startfight:
		if is_finding:
			# 取消生成
			is_finding = false
			virtual_plant.follow = false
			virtual_plant.hide()
			PlantsBarAutoload.is_planting = false
		elif not PlantsBarAutoload.is_planting:
			# 生成植物
			is_finding = true
			virtual_plant.follow = true
			virtual_plant.show()
			PlantsBarAutoload.is_planting = true
		return
	if has_chosen:
		# 已经选中，再次点击说明取消选择
		has_chosen = false
		position = on_board_pos
		PlantsBarAutoload.cancel(board_index)
	else:
		# 选中该植物
		if PlantsBarAutoload.choose == PlantsBarAutoload.maxnum:
			return
		var pos_get = PlantsBarAutoload.add()
		position.y = PlantsBarAutoload.bar_y
		position.x = pos_get[1]
		board_index = pos_get[0]
		has_chosen = true


func _on_cd_timeout():
	canplant = true
