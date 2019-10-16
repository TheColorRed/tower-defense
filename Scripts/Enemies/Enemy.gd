extends Unit
class_name Enemy

onready var bullet_point = find_node("Bullet Point")
onready var UI: Node2D = health_bar.get_parent()
onready var UI_start: Vector2 = UI.position

func _ready() -> void:
	UI.set_as_toplevel(true)

func _process(delta: float) -> void:
	UI.global_position = Vector2(global_position.x, global_position.y + UI_start.y)

func shoot() -> void:
	if target: emit_signal("create_bullet", "bullet", bullet_point, target, Global.Owner.Enemy, damage)

func on_bullet_hit(bullet: Bullet):
	if bullet.own != Global.Owner.Enemy:
		health_bar.value -= bullet.damage
		if is_instance_valid(bullet):
			bullet.queue_free()
		if health_bar.value <= 0 and is_instance_valid(self):
			queue_free()