class_name Habitat
extends Node2D

@export var inventory:Inventory
@onready var machine:Node2D = $machine
@onready var drop_area:Area2D = $machine/Drop_Detection
@onready var timer: Timer = $Timer
var energy: int = 100
var max_energy: int = 100

func _ready() -> void:
	print("inventory ", inventory.items)
	drop_area.area_entered.connect(_on_area_entered)
	timer.wait_time = 1.0   # elke seconde
	timer.timeout.connect(on_tick)
	timer.start()


func _on_area_entered(area:Area2D):
	if area is not PlayerItemHitbox: return
	var count := inventory.remove_item("crystal")
	print("crystal loaded ", count)
	if count >= 1:
		energy = energy + count * 10
	if energy > max_energy:
		energy = max_energy


func on_tick() -> void:
	if energy > 0:
		energy -= 1
		print("Energy:", energy)
	else:
		timer.stop()
		print("Energy is 0 — timer stopped.")

func time_left() -> float:
	return timer.time_left
