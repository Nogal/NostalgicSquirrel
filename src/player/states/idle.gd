extends StateMachine


func update(delta):
	player_movement()
	player.gravity(delta)
	if player.movement_input.x != 0:
		return states.MOVE
	if player.jump_input_actuation == true:
		return states.JUMP
	if player.velocity.y > 0:
		return states.FALL
	return null
