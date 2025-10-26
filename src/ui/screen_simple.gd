class_name ScreenSimple
extends CanvasLayer

signal done()

@onready var btn_start: Button = $MarginContainer/BtnStart

func _ready() -> void:
	btn_start.pressed.connect(on_done)

func on_done():
	done.emit()
