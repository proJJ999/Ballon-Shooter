extends RigidBody2D
class_name Ballon

var sizes = [0.8, 0.6, 0.4]
var size_level = 3

# Called when the node enters the scene tree for the first time.
func _ready():
	var types = $AnimatedSprite2D.sprite_frames.get_animation_names()
	$AnimatedSprite2D.play(types[randi()%3])

func change_size_level(size):
	var percentage = sizes[size - 1]
	$CollisionShape2D.scale = Vector2(percentage, percentage)
	$AnimatedSprite2D.scale = Vector2(percentage, percentage)
	self.size_level = size

func get_size_level():
	return size_level

func get_radiant():
	var animation = $AnimatedSprite2D
	var animation_name = animation.animation
	var frame = animation.frame
	var texture = animation.sprite_frames.get_frame_texture(animation_name, frame)
	var max_radiant = texture.get_size().x
	return max_radiant * sizes[size_level - 1] / 2

