class_name Inventory
extends Node2D

signal updated()

var items:Array[ItemStack] = []

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func add_item(item:CollectableStats):
	for el in items:
		if el.item.id == item.id:
			el.count += 1
			return
	items.append(ItemStack.new(item, 1))
	updated.emit()

class ItemStack:
	var item:CollectableStats
	var count:int

	func _init(item:CollectableStats, count:int) -> void:
		self.item = item
		self.count = count
