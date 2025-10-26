class_name ScreenGameOver
extends CanvasLayer

signal done()
signal open_credits()

@onready var btn_credits: Button = $MarginContainer/VBoxContainer/BtnCredits
@onready var btn_restart: Button = $MarginContainer/VBoxContainer/BtnRestart

func _ready() -> void:
	btn_restart.pressed.connect(on_done)
	btn_credits.pressed.connect(on_credits)

func on_done():
	done.emit()

func on_credits():
	open_credits.emit()
