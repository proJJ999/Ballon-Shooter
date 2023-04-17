extends State

func update(_delta: float) -> void:
	if Input.is_action_just_released("shoot"):
		state_machine.transition_to("Shooting")

func enter(_msg := {}) -> void:
	pass

func exit() -> void:
	owner.get_node("Cannon").set_process(false)
