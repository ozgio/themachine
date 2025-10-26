class_name ScreenSimple
extends CanvasLayer

signal done()
signal open_credits()

@onready var btn_start: Button =  find_child("BtnStart")

func _ready() -> void:
	btn_start.pressed.connect(on_done)
	var btn_credits = find_child("BtnCredits")
	if btn_credits != null:
		btn_credits.pressed.connect(open_credits.emit)

func on_done():
	done.emit()
