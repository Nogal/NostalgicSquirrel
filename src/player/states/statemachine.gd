extends Node

class_name StateMachine

var states = null
var player = null

func enter_state():
	pass
	
func exit_state():
	pass

func update(delta):
	return null

func player_movement():
	
	player.velocity.x = player.movement_input.x * player.SPEED
		
