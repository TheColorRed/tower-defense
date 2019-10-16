extends Enemy
class_name Tank

onready var barrel = get_node("Body/Barrel")
var cooldown_timer: Timer = null

func _process(delta):
	target = closest()
	if target:
		barrel.look_at(target.position)

func first_shot() -> void:
	cooldown_timer = Timer.new()
	cooldown_timer.wait_time = cooldown
	cooldown_timer.autostart = true
	cooldown_timer.connect("timeout", self, "shoot")
	add_child(cooldown_timer)

	target = closest()
	if target: barrel.look_at(target.position)
	shoot()