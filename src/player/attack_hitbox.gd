class_name AttackHitbox
extends Area2D

signal finished()

enum Owner {
	player,
	enemy,
}

@export var weapon:WeaponHolder
@export var group:Owner
@export var timeout:float = 0
var knockback_dir:Vector2

@export var debug_name:String
var _attacking:bool = false
@export var attacking:bool = _attacking:
	get:
		return _attacking
	set(val):
		_attacking = val

func _ready() -> void:
	attacking = _attacking

func get_damage() -> float:
	return weapon.stats.damage

func attack(timeout:float = -1):
	if attacking: return
	if timeout <=0:
		timeout = weapon.stats.speed
	print("start attacking, timeout: ", timeout)
	attacking = true
	get_tree().create_timer(timeout).timeout.connect(_on_attack_timout_end)

#
#func start_attack():
	#if _attacking: return
	#print("_attacking")
	#_attacking = true
	#attack_timer.start()
	#attack_hitbox.monitorable = true
#
func _on_attack_timout_end():
	print("attack finished")
	#attacking = false
	finished.emit()
