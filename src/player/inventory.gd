class_name Inventory
extends Node2D

signal updated()

var items:Array[ItemStack] = []

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


func add_item(item:CollectableStats):
	for el in items:
		if el.item.id == item.id:
			el.count += 1
			updated.emit()
			return
	items.append(ItemStack.new(item, 1))
	updated.emit()

func remove_item(id: String) -> int:
	for el in items:
		if el.item.id == id and el.count > 0:
			var count := el.count
			el.count = 0
			updated.emit()
			return count
	return 0

class ItemStack:
	var item:CollectableStats
	var count:int

	func _init(item:CollectableStats, count:int) -> void:
		self.item = item
		self.count = count
