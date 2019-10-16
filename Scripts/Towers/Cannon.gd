extends Tower
class_name Cannon

export var bullet: PackedScene = null
var cooldown_timer: Timer = null

func _process(delta: float) -> void:
	target = closest()
	if !target and is_instance_valid(cooldown_timer):
		cooldown_timer.queue_free()


func first_shot() -> void:
	cooldown_timer = Timer.new()
	cooldown_timer.wait_time = cooldown
	cooldown_timer.autostart = true
	cooldown_timer.connect("timeout", self, "shoot")
	add_child(cooldown_timer)

	target = closest()
	shoot()