extends KinematicBody2D

export var speed : int = 500
export var jump_speed : int = 800
export var gravity : int = 2000
export var coins : int = 0

var velocity = Vector2()

func _physics_process(delta):
	get_input(delta)


func get_input(delta):
	velocity.x = 0
	if Input.is_action_pressed("move_right"):
		velocity.x += speed
		$Sprite.flip_h = false
		$Sprite.animation = "walk"
	elif Input.is_action_pressed("move_left"):
		velocity.x -= speed
		$Sprite.flip_h = true
		$Sprite.animation = "walk"
	else:
		$Sprite.animation = "idle"
	
	if not is_on_floor():
		$Sprite.animation = "jump"
	if Input.is_action_pressed("jump"):
		if is_on_floor():
			velocity.y -= jump_speed
			$Sprite.animation = "jump"
	if Input.is_action_pressed("duck"):
		if is_on_floor():
			$Sprite.animation = "duck"

	#gravity
	velocity.y += gravity * delta
	velocity = move_and_slide(velocity, Vector2.UP)
	
	velocity.x = lerp(velocity.x,0, 0.1)
	



func _on_FallZone_body_entered(body):
	get_tree().change_scene("res://scenes/MainScene.tscn")

func add_coin():
	coins += 1
