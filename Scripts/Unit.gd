extends Node2D
class_name Unit

signal create_bullet

var targets: Array = Array()
var target = null

export var cooldown: float = 2
export var damage: float = 10
#export(int, LAYERS_2D_PHYSICS) var mask = 0

onready var health_bar: ProgressBar = find_node("Health Bar")
#onready var bullets = get_tree().get_root().find_node("Bullets", true, false)

func shoot() -> void: pass
func first_shot() -> void: pass

func closest() -> Node2D:
	var target = null
	var curr_dist = INF
	for i in targets:
		var dist = i.global_position.distance_to(global_position)
		if(dist < curr_dist):
			target = i
			curr_dist = dist
	return target if target != null else null

func first() -> Node2D:
	var target = null
	var curr_dist = INF
	for i in targets:
		var parent = i.get_parent()
		if(parent.offset > target.offset):
			target = parent
	return target

func on_view_enter(other) -> void:
	if !targets.has(other):
		targets.append(other)
		if !is_instance_valid(target):
			first_shot()

func on_view_exit(other) -> void:
	var idx = targets.find(other)
	if idx > -1:
		targets.remove(idx)