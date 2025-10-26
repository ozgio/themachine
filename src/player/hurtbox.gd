class_name Hurtbox
extends Area2D

@export var cooldown:float = 1.0
var cooldown_started_at:float
@export var vulnerable_to:Array[AttackHitbox.Owner] = []
@export var debug_name:String = "hurtbox"
var last_knockback_dir:Vector2
var attackers:Array[AttackHitbox] = []

signal hurt(damage:float)

func _ready() -> void:
	#monitorable = false
	#monitoring = true
	if vulnerable_to.size() == 0:
		print("warning: vulnerable_to is empty")
	self.area_entered.connect(_on_area_entered)
	self.area_exited.connect(_on_area_exited)

func _physics_process(delta: float) -> void:
	if attackers.size()==0: return

	var current := Time.get_unix_time_from_system()
	if (current - cooldown_started_at) < cooldown:
		#print("still in cooldown period")
		return

	for hitbox in attackers:
		if hitbox.attacking:
			take_hit(hitbox)
			return


func _on_area_entered(area:Area2D):
	#print(debug_name, " _on_area_entered ", area)
	if area is not AttackHitbox: return
	var hitbox := (area as AttackHitbox)
	if vulnerable_to.find(hitbox.group) < 0:
		print(debug_name, " is not vulnerable to ", hitbox.group)
		return

	if attackers.find(hitbox) >= 0:
		print(debug_name, ": already in attacker list: ", hitbox)
		return
	attackers.append(hitbox)

func take_hit(hitbox:AttackHitbox):
	print("take_hit by ", hitbox.debug_name)
	var current := Time.get_unix_time_from_system()
	if (current - cooldown_started_at) < cooldown:
		print("still in cooldown period")
		return
	last_knockback_dir = hitbox.knockback_dir
	var damage := hitbox.get_damage()
	print(debug_name, " got hit, damage: ", damage)
	hurt.emit(damage)
	cooldown_started_at = current

func _on_area_exited(area:Area2D):
	if area is not AttackHitbox: return
	print(debug_name, " _on_area_exited ", area)
	var index := attackers.find(area)
	if index >=0:
		attackers.remove_at(index)
