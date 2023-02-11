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
# 种植需要耗费的阳光
var value
# CD时间
var CDtime
# 是否可以种植
var canplant = true
# 植物虚影场景
var virtual_plant_scene = preload("res://scene/plants/virtualplant.tscn")
# 放置在草坪上的植物虚影
var virtual_plant_pack
# 跟随鼠标的植物虚影
var virtual_plant_follow
# 透明着色器
var virtual_shader_script = preload("res://shader/alpha.gdshader")
var virtual_shader = ShaderMaterial.new()

func _ready():
	virtual_shader.shader = virtual_shader_script
	add_to_group("plants_card")

func cancel_virtual_plants_pack():
	virtual_plant_pack.pack = false
	virtual_plant_pack.hide()
	virtual_plant_follow.follow = false
	virtual_plant_follow.hide()
	
func init(card_image_path, plants_scene, sunvalue, CDtime_, respath, image_num):
	scale.x = 0.8
	scale.y = 0.8
	texture_normal = load(card_image_path)
	plant_scene = load(plants_scene)
	value = sunvalue
	CDtime = CDtime_
	$CD.wait_time = CDtime_
	virtual_plant_pack = virtual_plant_scene.instantiate()
	virtual_plant_pack.init(respath, image_num)
	virtual_plant_pack.get_node("AnimatedSprite2D").material = virtual_shader
	
	virtual_plant_follow = virtual_plant_scene.instantiate()
	virtual_plant_follow.init(respath, image_num)
	add_child(virtual_plant_pack)
	add_child(virtual_plant_follow)
	virtual_plant_pack.plant_myself.connect(plant_myself)

func plant_myself():
	is_finding = false
	var pos = get_viewport().get_mouse_position()
	var tmp = PlantsBarAutoload.turn_pos_to_grass(pos.x, pos.y)
	canplant = false
	PlantsBarAutoload.is_planting = false
	cancel_virtual_plants_pack()
	PlantsBarAutoload.sun -= value
	PlantsBarAutoload.has_planted_num += 1
	$CD.start()
	PlantsBarAutoload.has_planted[tmp[0]][tmp[1]] = true
	var plant = plant_scene.instantiate()
	add_child(plant)
	plant.init(tmp[0], tmp[1])

# 向上移动
func move_up(delta, speed):
	var p = Vector2(0, -1)
	p = p.normalized() * speed
	position += p * delta

# 记录当前坐标	
func set_pos():
	on_board_pos = position
	
func start_to_fight():
	# 如果未使用，删除自身
	if not has_chosen:
		virtual_plant_pack.del()
		virtual_plant_follow.del()
		virtual_shader.free()
		queue_free()
	else:
		$CD.start()

func _on_pressed():
	if PlantsBarAutoload.startfight:
		if not canplant or PlantsBarAutoload.sun < value or PlantsBarAutoload.has_planted_num == PlantsBarAutoload.max_planted:
			return
		if is_finding:
			# 取消生成
			is_finding = false
			PlantsBarAutoload.is_planting = false
			cancel_virtual_plants_pack()
		elif not PlantsBarAutoload.is_planting:
			# 生成植物
			is_finding = true
			virtual_plant_pack.pack = true
			virtual_plant_pack.show()
			virtual_plant_follow.follow = true
			virtual_plant_follow.show()
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
