extends RigidBody2D


# Called when the node enters the scene tree for the first time.
func _ready():
	var types = $AnimatedSprite2D.sprite_frames.get_animation_names()
	$AnimatedSprite2D.play(types[randi()%3])

func change_scale(percentage):
	$CollisionShape2D.scale = Vector2(percentage, percentage)
	$AnimatedSprite2D.scale = Vector2(percentage, percentage)

func _get_scale():
	return $CollisionObject2D.scale.x
