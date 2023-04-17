extends Node2D

signal missed
signal hit(body)

@export var cannonball_scene: PackedScene

var shootable = true

var MIN_SHOOTING_FORCE = 3000
var MAX_SHOOTING_FORCE = 8000
var shooting_force = MIN_SHOOTING_FORCE
var shooting_force_increase_speed = 5000

func _process(delta):
	if not shootable:
		return
		
	if Input.is_action_pressed("shoot"):
		shooting_force += shooting_force_increase_speed * delta
		shooting_force = clamp(shooting_force, MIN_SHOOTING_FORCE, MAX_SHOOTING_FORCE)
	if Input.is_action_just_released("shoot"):
		shoot()
		shooting_force = MIN_SHOOTING_FORCE

func shoot():
	shootable = false
	$ShotCooldown.start()
	
	var cannonball = create_cannonball()
	var force = Vector2.UP.rotated($Cannon.rotation + PI / 2) * shooting_force
	cannonball.apply_central_force(force)
	
	await $ShotCooldown.timeout
	shootable = true	

func create_cannonball():
	var cannonball = cannonball_scene.instantiate()
	cannonball.position = $CannonballSpawnpoint.position
	cannonball.missed.connect(on_missed)
	cannonball.hit.connect(on_hit)
	add_child(cannonball)
	return cannonball	

func on_missed():
	missed.emit()	

func on_hit(body):
	hit.emit(body)

func get_shooting_percentage():
	return (shooting_force - MIN_SHOOTING_FORCE) / (MAX_SHOOTING_FORCE - MIN_SHOOTING_FORCE)
