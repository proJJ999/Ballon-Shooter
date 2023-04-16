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
var shooting_force = MIN_SHOOTING_FORCE
var shooting_force_increase_speed = 5000

func _ready():
	MIN_BALLON_X_POS = get_window().size.x / 2 + 100
	MAX_BALLON_X_POS = get_window().size.x - 100
	MIN_BALLON_Y_POS = 100
	MAX_BALLON_Y_POS = get_window().size.y - 100
	spawn_ballons(3)
	$Hud.update_lifebar(lives)
	$Hud.show_game_over(false)
	
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

func _process(delta):
	if not shootable:
		return
		
	if Input.is_action_pressed("shoot"):
		shooting_force += shooting_force_increase_speed * delta
		shooting_force = clamp(shooting_force, MIN_SHOOTING_FORCE, MAX_SHOOTING_FORCE)
	if Input.is_action_just_released("shoot"):
		shoot()
		shooting_force = MIN_SHOOTING_FORCE
		
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
		$Hud.show_game_over(true)
		set_process(false)
	
func hit(body):
	if body is Ballon:
		score += body.get_size_level()
	$Hud.update_score(score)
	
