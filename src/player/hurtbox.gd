class_name Hurtbox
extends Area2D

@export var cooldown:float = 1.0
var cooldown_started_at:float
@export var vulnerable_to:Array[AttackHitbox.Owner] = []
@export var debug_name:String = "hurtbox"

signal hurt(damage:float)

func _ready() -> void:
	monitorable = false
	monitoring = true
	if vulnerable_to.size() == 0:
		print("warning: vulnerable_to is empty")
	self.area_entered.connect(_on_area_entered)

func _on_area_entered(area:Area2D):
	if area is not AttackHitbox: return
	var current := Time.get_unix_time_from_system()
	if (current - cooldown_started_at) < cooldown:
		print("still in cooldown period")
		return

	var hitbox := (area as AttackHitbox)
	if vulnerable_to.find(hitbox.group) < 0:
		print(debug_name, " is not vulnerable to ", hitbox.group)
		return

	var damage := hitbox.get_damage()
	print(debug_name, " got hit, damage: ", damage)
	hurt.emit(damage)
	cooldown_started_at = current
