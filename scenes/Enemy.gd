extends KinematicBody2D

var velocity = Vector2()
export var direction = -1
export var detects_cliffs = true
var speed = 2

func _ready():
	if direction == 1:
		$AnimatedSprite.flip_h = true
	$floor_checker.position.x = $CollisionShape2D.shape.get_extents().x * direction
	$floor_checker.enabled = detects_cliffs
	
	
func _physics_process(delta):
	if is_on_wall() or (not $floor_checker.is_colliding() and detects_cliffs and is_on_floor()):
		velocity.x = 0
		direction *= -1
		$AnimatedSprite.flip_h = not $AnimatedSprite.flip_h
		
	velocity.y += 20
	velocity.x += speed * direction
	
	velocity = move_and_slide(velocity, Vector2.UP)

	$floor_checker.position.x = $CollisionShape2D.shape.get_extents().x * direction



func _on_top_checker_body_entered(body):
	speed = 0
	$AnimatedSprite.play("squash")
	set_collision_layer_bit(4,false)
	set_collision_mask_bit(0,false)
	$top_checker.set_collision_layer_bit(4,false)
	$top_checker.set_collision_mask_bit(0,false)


func _on_sides_checker_body_entered(body):
	print(body.get_name())
	get_tree().change_scene("res://scenes/MainScene.tscn")
	
