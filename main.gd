extends Node

@export var cannonball_scene: PackedScene
var shootable = true
var score = 0

var MIN_SHOOTING_FORCE = 3000
var MAX_SHOOTING_FORCE = 8000
var shooting_force = 3000
var shooting_force_increase_speed = 5000

func _process(delta):
	if not shootable:
		return
	
	if Input.is_action_just_pressed("shoot"):
		shooting_force = MIN_SHOOTING_FORCE
	if Input.is_action_pressed("shoot"):
		shooting_force += shooting_force_increase_speed * delta
		shooting_force = clamp(shooting_force, MIN_SHOOTING_FORCE, MAX_SHOOTING_FORCE)
	if Input.is_action_just_released("shoot"):
		shoot()
		
	update_progressbar()

func shoot():
	shootable = false
	$CannonballCooldown.start()
	
	var cannonball = create_cannonball()
	var force = Vector2.UP.rotated($Cannon.rotation + PI / 2) * shooting_force
	cannonball.apply_central_force(force)
	
	await $CannonballCooldown.timeout
	shootable = true
	
func create_cannonball():
	var cannonball = cannonball_scene.instantiate()
	cannonball.position = $StartPoint.position	
	cannonball.missed.connect(missed)
	cannonball.hit.connect(hit)
	add_child(cannonball)
	return cannonball
	
func update_progressbar():
	var percentige = (shooting_force - MIN_SHOOTING_FORCE) / (MAX_SHOOTING_FORCE - MIN_SHOOTING_FORCE)
	$Hud.update_progress_bar(percentige)

func missed():
	score -= 1
	$Hud.update_score(score)
	
func hit():
	score += 1
	$Hud.update_score(score)
	
