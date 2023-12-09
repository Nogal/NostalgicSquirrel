extends StateMachine

@onready var coyote_timer = $CoyoteTime
@onready var jump_buffer_timer = $JumpBuffer

@export var coyote_duration = 0.2
@export var jump_buffer_duration = 0.1

var can_jump = true
var wants_jump = false

func update(delta):
	player.gravity(delta)
	player_movement()
	if player.is_on_floor():
		if wants_jump:
			return states.JUMP
		else:
			return states.IDLE
	if player.jump_input_actuation and can_jump:
		return states.JUMP
	if player.jump_input_actuation and can_jump == false:
		jump_buffer_timer.start(jump_buffer_duration)
		wants_jump = true
	return null

func enter_state():
	if player.previous_state == states.IDLE or player.previous_state == states.MOVE:
		can_jump = true
		coyote_timer.start(coyote_duration)
	else:
		can_jump = false
	pass

func _on_coyote_time_timeout():
	can_jump = false

func _on_jump_buffer_timeout():
	wants_jump = false
