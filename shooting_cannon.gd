extends Node2D

@export var projectile_scene: PackedScene

signal missed
signal hit(body)

var MIN_SHOOTING_FORCE = 3000
var MAX_SHOOTING_FORCE = 8000
var shooting_force = MIN_SHOOTING_FORCE
var shooting_force_increase_speed = 5000

func on_missed():
	missed.emit()

func on_hit(body):
	hit.emit(body)

func get_shooting_percentage():
	return (shooting_force - MIN_SHOOTING_FORCE) / (MAX_SHOOTING_FORCE - MIN_SHOOTING_FORCE)

