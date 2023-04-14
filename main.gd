extends Node

@export var cannonball_scene: PackedScene
var shootable = true
var shooting_force = 5000 

func _process(delta):
	if not shootable:
		return
	if Input.is_action_pressed("shoot"):
		print("fff")
		shoot()

func shoot():
	shootable = false
	$CannonballCooldown.start()
	
	var cannonball = cannonball_scene.instantiate()
	cannonball.position = $StartPoint.position
	var force = Vector2.UP.rotated($Cannon.rotation + PI / 2) * shooting_force
	cannonball.apply_central_force(force)
	add_child(cannonball)
	
	await $CannonballCooldown.timeout
	shootable = true
	
	
