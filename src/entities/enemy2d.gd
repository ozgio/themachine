class_name Enemy
extends CharacterBody2D

signal dead()

@onready var hurtbox:Hurtbox = $Hurtbox
@onready var playerDetection:Area2D = $PlayerDetection

@export var stats:CharStats
@export var weapon_stats:WeaponStats
@export var speed := 10.0
var friction:float = 500.0

@onready var take_hit_effect:GPUParticles2D = $TakeHitEffect
@onready var bar:ColorRect = $Hud/HealthBarBG/HealthBar
var full_bar_width:float


enum State{
	idle,
	chasing,
	attacking,
	take_hit,
	dead,
}

var state:State = State.idle
var max_health := 100.0
var health := 100.0

func _ready() -> void:
	full_bar_width = bar.size.x
	hurtbox.hurt.connect(_on_damage)
	playerDetection.area_entered.connect(_on_detection_area_entered)
	playerDetection.area_exited.connect(_on_detection_area_exited)

func _process(delta: float) -> void:
	bar.scale.x = (health / max_health)

func _physics_process(delta):
	if state == State.dead: return
	#deal_with_damage()
	match state :
		State.idle:
			pass
		State.chasing:
			chase()
		State.take_hit:
			velocity = hurtbox.last_knockback_dir * 200
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
	health -= damage * 5
	print("enemy got hit. damage: ", damage, "health: ", health)
	if health <= 0:
		health = 0
		#take_hit_effect.restart()
		# TODO death animation
		state = State.dead
		var tweener := Tweenx.fadeOutNode(find_child("GreenBlob"), 0.2)
		await tweener.finished
		dead.emit()
		queue_free()
	else:
		state = State.take_hit

#
func _on_detection_area_entered(body: Node2D) -> void:
	state = State.chasing
	#player = body
	#player_chase = true
#
func _on_detection_area_exited(body: Node2D) -> void:
	state = State.idle
