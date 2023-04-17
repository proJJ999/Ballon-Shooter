extends Node

var score = 0
var lives = 3

func _ready():
	$Hud.update_lifebar(lives)
	$Hud.show_game_over(false)

func _process(delta):
	update_progressbar()

func update_progressbar():
	var percentage = $ShootingCannon.get_shooting_percentage()
	$Hud.update_progressbar(percentage)

func _on_shooting_cannon_hit(body):
	if body is Ballon:
		score += body.get_size_level()
	$Hud.update_score(score)

func _on_shooting_cannon_missed():
	lives -= 1
	$Hud.update_lifebar(lives)
	if lives == 0:
		$Hud.show_game_over(true)
		$ShootingCannon.set_process(false)
