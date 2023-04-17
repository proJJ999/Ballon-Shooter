extends Node2D

@export var ballon_scene: PackedScene

var MIN_BALLON_X_POS
var MAX_BALLON_X_POS
var MIN_BALLON_Y_POS
var MAX_BALLON_Y_POS

# Called when the node enters the scene tree for the first time.
func _ready():
	MIN_BALLON_X_POS = get_window().size.x / 2 + 100
	MAX_BALLON_X_POS = get_window().size.x - 100
	MIN_BALLON_Y_POS = 100
	MAX_BALLON_Y_POS = get_window().size.y - 100
	spawn_ballons(3)

func spawn_ballons(ballon_number):
	var ballons = []
	for i in range(ballon_number):
		var ballon = ballon_scene.instantiate()
		var position_invalid = true
		while(position_invalid):
			ballon.position.x = randi_range(MIN_BALLON_X_POS, MAX_BALLON_X_POS)
			ballon.position.y = randi_range(MIN_BALLON_Y_POS, MAX_BALLON_Y_POS)
			ballon.change_size_level(randi_range(1, 3))
			position_invalid = is_overlapping(ballon, ballons)
		ballons.append(ballon)
		add_child(ballon)

func is_overlapping(new_ballon, ballons):
	for i in range(ballons.size()):
		var ballon = ballons[i]
		if ballon == null:
			return false
		var new_radiant = new_ballon.get_radiant()
		var ballon_radiant = ballon.get_radiant()
		var position_diff = new_ballon.position.distance_to(ballon.position)
		if (position_diff <= new_radiant + ballon_radiant):
			return true
	return false
