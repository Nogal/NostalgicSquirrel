extends StateMachine

func update(delta):
	player.gravity(delta)
	player_movement()
	if player.velocity.x == 0:
		return states.IDLE
	if player.velocity.y > 0:
		return states.FALL
	if player.jump_input_actuation:
		return states.JUMP
	return null
