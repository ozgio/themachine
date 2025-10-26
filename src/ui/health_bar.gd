extends Control

@onready var amountLabel:Label = $Amount
@onready var bar:ColorRect = $Background/Bar
var full_bar_width:float

@export var player:Player

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	full_bar_width = bar.size.x

func _process(delta: float) -> void:
	bar.scale.x = (player.health / player.max_health)
	amountLabel.text = str(int(player.health)) + "/" + str(int(player.max_health))
