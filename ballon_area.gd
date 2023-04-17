extends Node2D

@export var ballon_scene: PackedScene

var min_ballon_x_pos
var max_ballon_x_pos
var min_ballon_y_pos
var max_ballon_y_pos

# Called when the node enters the scene tree for the first time.
func _ready():
	min_ballon_x_pos = get_window().size.x / 2 + 100
	max_ballon_x_pos = get_window().size.x - 100
	min_ballon_y_pos = 100
	max_ballon_y_pos = get_window().size.y - 100
	spawn_ballons(3)

func spawn_ballons(ballon_number):
	var ballons = []
	for i in range(ballon_number):
		var ballon = ballon_scene.instantiate()
		var position_invalid = true
		while(position_invalid):
			ballon.position.x = randi_range(min_ballon_x_pos, max_ballon_x_pos)
			ballon.position.y = randi_range(min_ballon_y_pos, max_ballon_y_pos)
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
