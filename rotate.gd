extends State

func update(_delta: float) -> void:
	pass

func enter(_msg := {}) -> void:
	owner.get_node("Cannon").set_process(true)
	owner.get_node("ShotCooldown").start()

func exit() -> void:
	pass
