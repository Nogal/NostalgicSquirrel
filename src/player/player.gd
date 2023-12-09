extends CharacterBody2D

#player_movement
@export var tile_size = 8
@export var jump_height : float = 3.1
@export var time_to_peak : float = 0.3
@export var jump_distance : float = 6.5
var SPEED = (jump_distance * tile_size) / (2 * time_to_peak)
var gravity = (2*(jump_height * tile_size)/pow(time_to_peak, 2))
var JUMP_VELOCITY = -gravity * time_to_peak


func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta

	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("move_left", "move_right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()
