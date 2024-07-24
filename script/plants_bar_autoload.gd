extends Node

# 最大卡槽数
const MAXNUM = 8
# 卡槽y坐标
const BAR_Y = 8
# 最大种植数量
const MAX_PLANTED = 45
# 被选中的卡片
var choose = 0
# 标记卡槽是否使用
var used = [false, false, false, false, false, false, false, false]
# 卡槽坐标
var pos = [78, 130, 184, 238, 292, 347, 400, 455]
# 是否开始战斗
var startfight = false
# 每一列僵尸的数量
var zombie_number = [0, 0, 0, 0, 0]
# 当前阳光数
var sun = 1000
# 一朵阳光添加的阳光数
var sun_add_once = 50
# Y轴坐标
var grassy = [120, 220, 320, 420, 520]
# X轴坐标
var grassx = [300, 380, 460, 540, 620, 700, 780, 860, 940]
# 是否当前有植物正准备种植
var is_planting = false
# 标记是否种植
var has_planted: Array
# 标记种植数量
var has_planted_num = 0


func _ready():
	for i in range(9):
		has_planted.append([])
		for j in range(5):
			has_planted[i].append(false)


func add():
	for i in range(0, MAXNUM):
		if not used[i]:
			used[i] = true
			choose += 1
			return [i, pos[i]]


# 将自己的坐标转换成草坪上的坐标
func turn_pos_to_grass(xinput, yinput):
	# 找到自己最接近哪个区域
	var x
	var xmin = 1e8
	var y
	var ymin = 1e8
	for i in range(0, len(PlantsBarAutoload.grassx)):
		var tmp = abs(xinput - PlantsBarAutoload.grassx[i])
		if tmp < xmin:
			xmin = tmp
			x = i
	for i in range(0, len(PlantsBarAutoload.grassy)):
		var tmp = abs(yinput - PlantsBarAutoload.grassy[i])
		if tmp < ymin:
			ymin = tmp
			y = i
	return [x, y]


# Cancel the selection
func cancel(index):
	used[index] = false
	choose -= 1
