extends Node2D

@export var p:Player
@onready var timer: Timer = $Timer
var energy: int = 45

func _ready() -> void:
	# Zorg dat de timer automatisch blijft lopen
	timer.wait_time = 1.0   # elke seconde
	timer.timeout.connect(on_tick)
	timer.start()

func on_tick() -> void:
	if energy > 0:
		energy -= 1
		print("Energy:", energy)
	else:
		timer.stop()
		print("Energy is 0 — timer stopped.")

func time_left() -> float:
	return timer.time_left
