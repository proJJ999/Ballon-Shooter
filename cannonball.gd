extends RigidBody2D

signal missed
signal hit

func _ready():
	contact_monitor = true
	max_contacts_reported = 1

func _on_visible_on_screen_enabler_2d_screen_exited():
	missed.emit()
	queue_free()

func _on_body_shape_entered(body_rid, body, body_shape_index, local_shape_index):
	hit.emit()
	queue_free()
