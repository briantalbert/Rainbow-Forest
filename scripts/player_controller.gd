extends KinematicBody2D

export var speed : int = 575

export var jump_speed : int = 800
export var gravity : int = 2000

var velocity = Vector2()

func _physics_process(delta):
	get_input(delta)


func get_input(delta):
	velocity.x = 0
	if Input.is_action_pressed("move_right"):
		velocity.x += speed
	if Input.is_action_pressed("move_left"):
		velocity.x -= speed
	if Input.is_action_pressed("jump"):
		if is_on_floor():
			velocity.y -= jump_speed
	if Input.is_action_just_pressed("duck"):
		if is_on_floor():
			pass

	#gravity
	velocity.y += gravity * delta
	velocity = move_and_slide(velocity, Vector2.UP)
	
	velocity.x = lerp(velocity.x,0, 0.1)
	print(velocity)
