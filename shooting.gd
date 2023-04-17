extends State

func update(_delta: float) -> void:
	if Input.is_action_pressed("shoot"):
		owner.shooting_force += owner.shooting_force_increase_speed * _delta
		owner.shooting_force = clamp(owner.shooting_force, owner.MIN_SHOOTING_FORCE, owner.MAX_SHOOTING_FORCE)
	if Input.is_action_just_released("shoot"):
		shoot()
		state_machine.transition_to("IdleRotate")

func exit() -> void:
	owner.shooting_force = owner.MIN_SHOOTING_FORCE

func shoot():
	var projectile = create_cannonball()
	var force = Vector2.UP.rotated(owner.get_node("Cannon").rotation + PI / 2) * owner.shooting_force
	projectile.apply_central_force(force)

func create_cannonball():
	var projectile = owner.projectile_scene.instantiate()
	projectile.position = owner.get_node("CannonballSpawnpoint").position
	projectile.missed.connect(owner.on_missed)
	projectile.hit.connect(owner.on_hit)
	owner.add_child(projectile)
	return projectile
