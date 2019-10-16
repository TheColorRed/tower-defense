extends Node2D

onready var path = find_node("PathA")
export var unit_map: Resource
export var bullets: Resource

export var current_round = 0

func _ready() -> void:
	yield(get_tree().create_timer(1), "timeout")
	if is_instance_valid(self):
		var rounds = load_rounds("res://easy.json")
		run_round(rounds[current_round])

func run_round(rnd: Array) -> void:
	for itm in rnd:
		if typeof(itm) == TYPE_INT or typeof(itm) == TYPE_REAL:
			yield(get_tree().create_timer(itm), "timeout")
		if typeof(itm) == TYPE_STRING:
			var unit: PackedScene = unit_map.get(itm)
			if unit:
				var inst: Node2D = unit.instance()
				inst.connect("create_bullet", self, "on_create_bullet")

				var follow: PathFollow2D = PathFollow2D.new()
				follow.loop = false
				follow.set_script(preload("res://Scripts/FollowPath.gd"))
				follow.add_child(inst)
				follow.v_offset = rand_range(-25, 25)
				path.add_child(follow)

func on_create_bullet(bullet: String, bullet_point: Node2D, target: Node2D, bullet_owner, damage: float) -> void:
	if is_instance_valid(target):
		var scene: PackedScene = bullets.get(bullet)
		if is_instance_valid(scene):
			var b: Bullet = scene.instance()
			b.own = bullet_owner
			b.damage = damage
			b.target = target.get_path()
			b.start = bullet_point.get_path()
			get_node("Level Layer/Bullets").call_deferred("add_child", b)

func load_rounds(path: String) -> JSONParseResult:
	var file = File.new()
	assert file.file_exists(path)
	file.open(path, file.READ)
	return parse_json(file.get_as_text())

func on_exit() -> void:
	get_tree().quit()