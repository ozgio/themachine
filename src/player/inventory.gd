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

func remove_item(id: String) -> bool:
	for el in items:
		if el.item.id == id and el.count > 0:
			el.count -= 1
			updated.emit()
			return true
	return false

class ItemStack:
	var item:CollectableStats
	var count:int

	func _init(item:CollectableStats, count:int) -> void:
		self.item = item
		self.count = count
