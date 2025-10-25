extends CharacterBody2D

const speed = 200
var current_dir = "none"

var enemy_in_attack_range = false
var enemy_cooldown = true
var health = 100
var player_alive = true

var attack_ip = false

func _ready():
	$AnimatedSprite2D.play("idle")

func _physics_process(delta):
	player_movement(delta)
	enemy_attack()
	attack()
	
	if health <= 0:
		player_alive = false
		health = 0
		print("dead")
		self.queue_free()
		
	
func player_movement(delta):
	
	if Input.is_action_pressed("ui_right"):
		velocity.x = speed
		velocity.y = 0
		current_dir = "right"
		play_anim(1)
	elif Input.is_action_pressed("ui_left"):
		current_dir = "left"
		velocity.x = -speed
		velocity.y = 0
		play_anim(1)
	elif Input.is_action_pressed("ui_down"):
		current_dir = "down"
		velocity.y = speed
		velocity.x = 0
		play_anim(1)
	elif Input.is_action_pressed("ui_up"):
		current_dir = "up"
		velocity.y = -speed
		velocity.x = 0
		play_anim(1)
	else:
		play_anim(0)
		velocity.y = 0
		velocity.x = 0
	move_and_slide()

func play_anim(movement):
	var dir = current_dir
	var anim = $AnimatedSprite2D
	
	if dir == "right":
		anim.flip_h = false
		if movement == 1:
			anim.play("right_walk")
		elif movement == 0:
			if attack_ip == false:
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
			


func player():
	pass


func _on_player_hitbox_body_entered(body: Node2D) -> void:
	if body.has_method("enemy"):
		enemy_in_attack_range = true


func _on_player_hitbox_body_exited(body: Node2D) -> void:
	if body.has_method("enemy"):
		enemy_in_attack_range = false
		
func enemy_attack():
	if enemy_in_attack_range and enemy_cooldown == true:
		health = health - 20
		enemy_cooldown = false
		$attack_cooldown.start()
		print(health)


	

func _on_attack_cooldown_timeout() -> void:
	enemy_cooldown = true
	
func attack():
	var dir = current_dir
	
	if Input.is_action_just_pressed("attack"):
		global.player_current_attack = true
		attack_ip = true
		if dir == "right":
			$AnimatedSprite2D.flip_h = false
			$AnimatedSprite2D.play("sword_attack_right")
			$deal_attack_timer.start()
		if dir == "left":
			$AnimatedSprite2D.flip_h = true
			$AnimatedSprite2D.play("sword_attack_right")
			$deal_attack_timer.start()
		if dir == "down":
			$AnimatedSprite2D.play("sword_attack_front")
			$deal_attack_timer.start()
		if dir == "up":
			$AnimatedSprite2D.play("sword_attack_back")
			$deal_attack_timer.start()






func _on_deal_attack_timer_timeout() -> void:
	$deal_attack_timer.stop()
	global.player_current_attack = false
	attack_ip = false
