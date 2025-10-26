extends Node2D

@export var inventory:Inventory
@onready var machine:Node2D = $machine
@onready var drop_area:Area2D = $machine/Drop_Detection

func _ready() -> void:
	print("inventory ", inventory.items)
	drop_area.area_entered.connect(_on_area_entered)
	

func _on_area_entered(area:Area2D):
	if area is not PlayerItemHitbox: return
	inventory.remove_item("crystal")
