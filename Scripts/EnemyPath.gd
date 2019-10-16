extends Node2D
class_name EnemyPath

onready var paths: Array = get_children()

func _ready() -> void:
	create_enemy()
	pass

func create_enemy() -> void:
	pass