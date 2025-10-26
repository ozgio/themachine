extends Node2D

@onready var screen_game_over: ScreenGameOver = $Screens/ScreenGameOver
@onready var screen_start: ScreenSimple = $Screens/ScreenHowTo
@onready var screen_credits: ScreenSimple = $Screens/ScreenCredits
@onready var habitat: Habitat = $Habitat
@onready var screens: CanvasLayer = $Screens


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	screens.hide()
	habitat.game_over.connect(on_game_over)
	screen_game_over.done.connect(on_start_game)
	screen_game_over.open_credits.connect(on_open_credits)
	screen_start.done.connect(on_start_game)
	screen_credits.done.connect(on_start_game)
	habitat.stop_timer()
	set_process(false)
	show_start()


func on_start_game():
	screens.hide()
	hide_screens()
	habitat.reset_machine()
	set_process(true)

func show_start():
	screens.show()
	hide_screens()
	screen_start.show()

func on_open_credits():
	screens.show()
	hide_screens()
	screen_credits.show()


func hide_screens():
	screen_credits.hide()
	screen_start.hide()
	screen_game_over.hide()

func on_game_over():
	screens.show()
	hide_screens()
	screen_game_over.show()
	set_process(false)
