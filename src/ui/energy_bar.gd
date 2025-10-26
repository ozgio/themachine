extends Control

@onready var amountLabel:Label = $Amount
@onready var bar:ColorRect = $Background/Bar
var full_bar_width:float

@export var habitat:Habitat

func _ready() -> void:
	full_bar_width = bar.size.x

func _process(delta: float) -> void:
	bar.scale.x = (float(habitat.energy) / float(habitat.max_energy))
	amountLabel.text = str(int(habitat.energy)) + "/" + str(int(habitat.max_energy))
