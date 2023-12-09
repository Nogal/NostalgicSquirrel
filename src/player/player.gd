extends CharacterBody2D

#player_movement
@export var tile_size = 8
@export var jump_height : float = 3.1
@export var time_to_peak : float = 0.3
@export var jump_distance : float = 6.5
var SPEED = (jump_distance * tile_size) / (2 * time_to_peak)
var gravity_value = (2*(jump_height * tile_size)/pow(time_to_peak, 2))
var JUMP_VELOCITY = -gravity_value * time_to_peak

var previous_state = null
var current_state = null

var movement_input = Vector2.ZERO
var jump_input = false
var jump_input_actuation = false

@onready var states = $States

func _ready():
	for state in states.get_children():
		state.states = states
		state.player = self
	previous_state = states.IDLE
	current_state = states.IDLE

func _physics_process(delta):
	player_input()
	$Label.text = str(current_state.get_name())
	change_state(current_state.update(delta))
	move_and_slide()

func change_state(input_state):
	if input_state != null:
		previous_state = current_state
		current_state = input_state

		previous_state.exit_state()
		current_state.enter_state()

func player_input():
	movement_input = Vector2.ZERO
	jump_input = false
	jump_input_actuation = false

	if Input.is_action_pressed("move_right"):
		movement_input.x +=1
	if Input.is_action_pressed("move_left"):
		movement_input.x -=1
	if Input.is_action_pressed("move_up"):
		movement_input.y -=1
	if Input.is_action_pressed("move_down"):
		movement_input.y +=1

	if Input.is_action_pressed("jump"):
		jump_input = true
	if Input.is_action_just_pressed("jump"):
		jump_input_actuation = true

func gravity(delta):
	if not is_on_floor():
		velocity.y += gravity_value * delta
