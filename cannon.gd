extends Sprite2D

@export var angular_speed = PI/4
var speed = angular_speed/4
var direction = 1

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	update_direction()
	rotation += angular_speed * delta * direction
	
	var velocity = Vector2.DOWN.rotated(rotation) * speed * direction
	position += velocity
	
func update_direction():
	if(rotation > 0):
		direction = -1
	if(rotation < -PI / 2):
		direction = 1
