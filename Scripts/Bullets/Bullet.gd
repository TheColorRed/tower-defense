extends Node2D
class_name Bullet

export var speed: float = 100
export var damage: float = 1
export var ttl: float = 0.5
export(Global.Owner) var own = Global.Owner.None

export var target: NodePath
export var start: NodePath

onready var timer = get_tree().create_timer(ttl)

func _ready() -> void:
	global_position = get_node(start).global_position
	look_at(get_node(target).global_position)

func _process(delta: float) -> void:
	translate(transform.x * speed * delta)
	if timer.time_left <= 0:
		queue_free()