extends Unit
class_name Tower

onready var bullet_point = find_node("Bullet Point")

onready var level = get_node("/root/Level")

func _ready() -> void:
	if !self.is_connected("create_bullet", level, "on_create_bullet"):
		self.connect("create_bullet", level, "on_create_bullet")

func shoot() -> void:
	if target: emit_signal("create_bullet", "bullet", bullet_point, target, Global.Owner.Player, damage)

func on_bullet_hit(bullet: Bullet):
	if bullet.own != Global.Owner.Player:
		health_bar.value -= bullet.damage
		if is_instance_valid(bullet):
			bullet.queue_free()
		if health_bar.value <= 0 and is_instance_valid(self):
			queue_free()