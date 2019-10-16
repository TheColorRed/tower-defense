extends Container

export var level: PackedScene

func on_play_easy() -> void:
	get_tree().change_scene_to(level)