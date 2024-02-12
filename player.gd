extends CharacterBody2D
@onready var animation = $AnimatedSprite2D
#@onready var score = get_node("Camera2D/Label")
var mode = 0
const SPEED = 300.0
const JUMP_VELOCITY = -350.0
# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var dir = -1
var active = true
var flytokens = 1000
func _physics_process(delta):
	# Add the gravity."
	if Input.is_action_just_pressed("evolve") and flytokens >= 5 and mode == 0 and $Timer.time_left == 0 and is_on_floor():
		flytokens -= 5
		#if mode == 0:
		mode = 1
		$Timer.start()
		active = true
	elif mode == 2 and $Timer.time_left == 0:
		$Timer.start()
		active = true
	if mode == 0:
		animation.play("caterpie")
		if not is_on_floor():
			velocity.y += gravity * delta

		# Handle Jump.
		if Input.is_action_just_pressed("ui_up") and is_on_floor():
			velocity.y = JUMP_VELOCITY
		
		# Get the input direction and handle the movement/deceleration.
		# As good practice, you should replace UI actions with custom gameplay actions.
		var direction = Input.get_axis("ui_left", "ui_right")
		if direction:
			if direction*dir < 0:
				dir = -1*dir
				scale.x = -scale.x
			velocity.x = direction * SPEED
		else:
			velocity.x = 0
		move_and_slide()
	elif mode == 1:
		if not is_on_floor():
			velocity.y += gravity * delta
		animation.play("cocoon")
	
	elif mode == 2:
		animation.play("fly_mode")
		# Get the input direction and handle the movement/deceleration.
		# As good practice, you should replace UI actions with custom gameplay actions.
		var directiony = Input.get_axis("ui_up", "ui_down")
		var directionx = Input.get_axis("ui_left", "ui_right")
		if directionx:
			if directionx*dir > 0:
				dir = -1*dir
				scale.x = -scale.x
			velocity.x = directionx * SPEED
		else:
			velocity.x = 0
			
		if directiony:
			velocity.y = directiony * SPEED
		else:
			velocity.y = 0
		move_and_slide()




func inc():
	flytokens += 1


func _on_timer_timeout():
	if mode == 1:
		mode = 2 # Replace with function body.
	elif mode == 2:
		mode = 0




func _on_killer_area_body_entered(body):
	if body.name == "Player":
		get_tree().quit() # Replace with function body.
