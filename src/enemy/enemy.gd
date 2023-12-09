extends CharacterBody2D

@export var movement_speed : int = 8

var enemy_movement = Vector2.ZERO
var direction : int = 1

func _ready():
	var sign = sign(randi_range(0, 1))
	if sign == 0:
		sign -= 1
	direction = direction * sign

func _physics_process(_delta):
	enemy_movement.x = direction * movement_speed
	get_direction()
	move_and_slide()

func get_direction():
	if $RayCastLeft.is_colliding() == false or $RayCastRight.is_colliding() == false:
		direction = direction * -1
	if $RayCastForward.is_colliding() or $RayCastBackward.is_colliding():
		direction = direction * -1
		
	
