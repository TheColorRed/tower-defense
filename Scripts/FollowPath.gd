extends PathFollow2D
class_name FollowPath

export var move_speed: float = 100

func _process(delta) -> void:
	set_offset(get_offset() + move_speed * delta)
