extends CharacterBody2D

@onready var animatedSprite = $AnimatedSprite2D

var in_path = false

var SPEED = 300.0
const JUMP_VELOCITY = -400.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")


func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta

	# Handle Jump.
	animate()
	move_and_slide()

func animate():
	if not in_path:
		velocity.x = SPEED/4
		animatedSprite.play("normal")
	else:
		velocity.x = SPEED/1.5
		animatedSprite.play("attacking")
	var current_position = position
	move_and_slide()
	if position == current_position:
		scale.x = -scale.x
		SPEED = -SPEED

func _on_area_2d_body_entered(body):
	if body.name == "Player":
		in_path = true


func _on_area_2d_body_exited(body):
	
	if body.name == "Player":
		in_path = false


func _on_killer_area_body_entered(body):
	if body.name == "Player":
		get_tree().quit()
