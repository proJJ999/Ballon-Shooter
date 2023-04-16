extends Node

@export var cannonball_scene: PackedScene
@export var ballon_scene: PackedScene

var shootable = true
var score = 0
var lives = 3

var MIN_BALLON_X_POS
var MAX_BALLON_X_POS
var MIN_BALLON_Y_POS
var MAX_BALLON_Y_POS

var MIN_SHOOTING_FORCE = 3000
var MAX_SHOOTING_FORCE = 8000
var shooting_force = 3000
var shooting_force_increase_speed = 5000

func _ready():
	MIN_BALLON_X_POS = get_window().size.x / 2 + 100
	MAX_BALLON_X_POS = get_window().size.x - 100
	MIN_BALLON_Y_POS = 100
	MAX_BALLON_Y_POS = get_window().size.y - 100
	spawn_ballons(3)
	$Hud.update_lifebar(lives)
	

func spawn_ballons(ballon_number):
	for n in range(ballon_number):
		var ballon = ballon_scene.instantiate()
		ballon.position.x = randi_range(MIN_BALLON_X_POS, MAX_BALLON_X_POS)
		ballon.position.y = randi_range(MIN_BALLON_Y_POS, MAX_BALLON_Y_POS)
		ballon.change_scale(randf_range(0.4, 0.8))
		add_child(ballon)

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
	$Hud.update_progressbar(percentige)

func missed():
	lives -= 1
	$Hud.update_lifebar(lives)
	if lives == 0:
		set_process(false)
	
func hit():
	score += 1
	$Hud.update_score(score)
	
