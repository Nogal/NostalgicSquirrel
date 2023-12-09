extends StateMachine

func update(delta):
	player.gravity(delta)
	player_movement()
	if player.velocity.y > 0:
		return states.FALL
	return null

func enter_state():
	player.velocity.y = player.JUMP_VELOCITY
