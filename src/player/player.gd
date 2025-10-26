class_name Player
extends CharacterBody2D

@export var stats:CharStats
@onready var hurtbox:Hurtbox = $Hurtbox
@onready var attack_timer:Timer = $deal_attack_timer
@onready var attack_hitbox:AttackHitbox = $AttackHitbox
@export var spawn_area:Control

var speed:float
var health:float
var max_health:float
var current_dir = "none"

func _ready():
	speed = stats.speed
	health = stats.health
	max_health = stats.max_health
	if max_health < health:
		max_health = health
	hurtbox.hurt.connect(on_damage)
	$AnimatedSprite2D.play("idle")

func _physics_process(delta):
	player_movement(delta)
	if Input.is_action_pressed("attack"):
		start_attack()

func start_attack():
	if attack_hitbox.attacking: return
	print("attacking")
	attack_hitbox.attack()


func player_movement(delta):
	var input_vector = Input.get_vector( "move_left", "move_right", "move_up", "move_down")
	velocity = speed * input_vector
	var move := false
	if Input.is_action_pressed("move_right"):
		current_dir = "right"
		move = true
		play_anim(1)
	elif Input.is_action_pressed("move_left"):
		current_dir = "left"
		move = true
		play_anim(1)
	elif Input.is_action_pressed("move_down"):
		current_dir = "down"
		move = true
		play_anim(1)
	elif Input.is_action_pressed("move_up"):
		current_dir = "up"
		move = true
		play_anim(1)
	else:
		play_anim(0)
		velocity.y = 0
		velocity.x = 0
	if move:
		attack_hitbox.knockback_dir = input_vector.normalized()
	move_and_slide()

func play_anim(movement):
	var dir = current_dir
	var anim = $AnimatedSprite2D
	if dir == "right":
		anim.flip_h = false
		if movement == 1:
			anim.play("right_walk")
		elif movement == 0:
			anim.play("idle")
	if dir == "left":
		anim.flip_h = true
		if movement == 1:
			anim.play("right_walk")
		elif movement == 0:
			anim.play("idle")
	if dir == "down":
		anim.flip_h = true
		if movement == 1:
			anim.play("front_walk")
		elif movement == 0:
			anim.play("idle")
	if dir == "up":
		anim.flip_h = true
		if movement == 1:
			anim.play("back_walk")
		elif movement == 0:
			anim.play("idle")

func on_damage(damage:float):
	var anim = $AnimatedSprite2D
	health = health - damage
	if health <= 0:
		health = 0
	print("player get damage: ", damage, ",  health: ", health)
	if health <= 0:
		anim.play("dead")
		print("dead!")
		await Tweenx.fadeOutNode(self, 0.2).finished

		health = 100
		position = spawn_area.position
		Tweenx.fadeInNode(self, 0.1)
