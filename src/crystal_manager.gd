extends Node2D


@export var CrystalScene:PackedScene
@export var max_num_crystals := 6
var num_crystals := 0
@onready var spawnArea:Control = find_child("SpawnArea")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if num_crystals < max_num_crystals:
		var needed := max_num_crystals - num_crystals
		for i in range(needed):
			spawn_crystal()


func spawn_crystal():
	var crystal = CrystalScene.instantiate()
	num_crystals += 1
	crystal.picked.connect(on_picked)
	crystal.position.x = randi_range(spawnArea.position.x,spawnArea.position.x+ spawnArea.size.x)
	crystal.position.y = randi_range(spawnArea.position.y,spawnArea.position.y+ spawnArea.size.y)
	add_child(crystal)

func on_picked():
	num_crystals-=1
