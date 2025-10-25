extends StaticBody2D

@onready var area:Area2D = $Area2D
@export var stats:CollectableStats

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	area.area_entered.connect(_on_area_entered)
	pass # Replace with function body.


func _on_area_entered(area:Area2D):
	if area is not PlayerItemHitbox: return
	var invetory:Inventory = get_tree().get_first_node_in_group("Inventory")
	invetory.add_item(stats)
	var tween := Tweenx.new(self)
	tween.fadeOut(0.2)
	await tween.finished
	queue_free()
