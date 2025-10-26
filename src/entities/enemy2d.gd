extends CharacterBody2D

@onready var hurtbox:Hurtbox = $Hurtbox
@export var stats:CharStats
@export var weapon_stats:WeaponStats

var speed = 35
var player_chase = false
var player = null

var health = 100

var player_inattack_zone = false


func _ready() -> void:
	hurtbox.hurt.connect(_on_damage)

func _physics_process(delta):
	pass
	#deal_with_damage()


	#if player_chase:
		#position += (player.position - position)/speed

func _on_damage(damage:float):
	health -= damage
	print("hit. damage: ", damage, "health: ", health)
	if health <= 0:
		health = 0
		# TODO death animation
		queue_free()
	else:
		pass
		#TODO hit animation

#
#func _on_detection_area_body_entered(body: Node2D) -> void:
	#player = body
	#player_chase = true
#
#
#func _on_detection_area_body_exited(body: Node2D) -> void:
	#player = null
	#player_chase = false
#
#func enemy():
	#pass
#
#
#func _on_enemy_hitbox_body_entered(body: Node2D) -> void:
	#if body.has_method("player"):
		#player_inattack_zone = true
#
#
#func _on_enemy_hitbox_body_exited(body: Node2D) -> void:
	#if body.has_method("player"):
		#player_inattack_zone = true
#
#func deal_with_damage():
	#if player_inattack_zone and global.player_current_attack == true:
		#health = health - 20
		#print("slime health = ", health)
		#if health <= 0:
			#self.queue_free()
