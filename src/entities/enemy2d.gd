extends CharacterBody2D

@onready var hurtbox:Hurtbox = $Hurtbox
@onready var playerDetection:Area2D = $PlayerDetection

@export var stats:CharStats
@export var weapon_stats:WeaponStats
@export var speed := 10.0
var friction:float = 500.0

enum State{
	idle,
	chasing,
	attacking,
	take_hit,
}

var state:State = State.idle
var health = 100

func _ready() -> void:
	hurtbox.hurt.connect(_on_damage)
	playerDetection.area_entered.connect(_on_detection_area_entered)
	playerDetection.area_exited.connect(_on_detection_area_exited)

func _physics_process(delta):
	#deal_with_damage()
	match state :
		State.idle:
			pass
		State.chasing:
			chase()
		State.take_hit:
			velocity = hurtbox.last_knockback_dir * 100
			move_and_slide()
			get_tree().create_timer(0.1).timeout.connect(on_knockback_end)
	#if player_chase:
		#position += (player.position - position)/speed

func on_knockback_end():
	state = State.idle

func chase():
	var player:Player = get_tree().get_first_node_in_group("Player")
	var distance := player.global_position - global_position
	velocity = distance.normalized() * speed
	move_and_slide()

func _on_damage(damage:float):
	health -= damage
	print("enemy got hit. damage: ", damage, "health: ", health)
	if health <= 0:
		health = 0
		# TODO death animation
		queue_free()
	else:
		state = State.take_hit
		#TODO hit animation

#
func _on_detection_area_entered(body: Node2D) -> void:
	state = State.chasing
	#player = body
	#player_chase = true
#
func _on_detection_area_exited(body: Node2D) -> void:
	state = State.idle

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
