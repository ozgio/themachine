extends Node2D

@export var health:HealthResource

func _ready() -> void:
	$"Button".pressed.connect(on_pressed)

func on_pressed():
	health.health -= 1
	print("health: ", health.health)
