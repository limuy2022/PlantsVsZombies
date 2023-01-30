extends Node

# 被选中的卡片
var choose = 0
# 标记卡槽是否使用
var used = [false, false, false, false, false, false, false, false]
# 卡槽坐标
var pos = [78, 130, 184, 238, 292, 347, 400, 455]
# 最大卡槽数
const maxnum = 8
# 卡槽y坐标
const bar_y = 8
# 是否开始战斗
var startfight = false
# 每一列僵尸的数量
var zombie_number = [0, 0, 0, 0, 0]
# 当前阳光数
var sun = 0
# Y轴坐标
var grassy = []
# X轴坐标
var grassx = []
# 是否当前有植物正准备种植
var is_planting = false

func add():
	for i in range(0, maxnum):
		if not used[i]:
			used[i] = true
			choose += 1
			return [i, pos[i]]

func cancel(index):
	used[index] = false
	choose -= 1
