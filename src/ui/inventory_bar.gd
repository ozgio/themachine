extends Control

@onready var contentLabel = $Content
@export var inventory:Inventory

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	inventory.updated.connect(_on_invetory_updated)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _on_invetory_updated() -> void:
	var text := ""
	for stack in inventory.items:
		if stack.count <= 0:
			continue
		text += stack.item.name + " x " + str(stack.count) + "  "
	if text == "":
		text == "-"
	contentLabel.text = text
