extends Container

@export var life_scene : PackedScene
var MAX_LIVES = 5
var next_position

func _ready():
	set_lives(1)

func set_lives(count):
	for child in get_children():
		child.queue_free()
	next_position = Vector2(30*count,25)
	
	count = clamp(count, 0, MAX_LIVES)
	for n in range(count):
		var life = life_scene.instantiate()
		life.position = next_position
		next_position.x -= 30
		add_child(life)
