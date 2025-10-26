class_name EnemyManager
extends Node2D


@export var EnemyScene:PackedScene
@export var max_num_enemies := 3
var num_enemies := 0
@onready var spawnArea:Control = find_child("SpawnArea")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if num_enemies < max_num_enemies:
		var needed := max_num_enemies - num_enemies
		for i in range(needed):
			spawn_enemy()


func spawn_enemy():
	var enemy:Enemy = EnemyScene.instantiate()
	num_enemies += 1
	enemy.dead.connect(on_dead)
	enemy.position.x = randi_range(spawnArea.position.x,spawnArea.position.x+ spawnArea.size.x)
	enemy.position.y = randi_range(spawnArea.position.y,spawnArea.position.y+ spawnArea.size.y)
	add_child(enemy)

func on_dead():
	num_enemies-=1
