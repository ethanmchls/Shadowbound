class_name WallClimbComponent
extends Node

func handle_wall_grab(player: CharacterBody2D, is_grabbing_wall, is_moving_up, is_moving_down, is_jumping, is_moving_left, is_moving_right):
	if (is_grabbing_wall and player.is_on_wall() and not player.is_on_floor()):
		if not is_moving_up and not is_moving_down and not is_jumping:
			player.velocity.y = 0

		if is_moving_up:
			player.velocity.y = -50

		if is_moving_down:
			player.velocity.y = 50

		if is_jumping:
			if is_moving_left:
				player.velocity.y = -250
				player.velocity.x = move_toward(player.velocity.x, -1, 200)
			elif is_moving_right:
				player.velocity.y = -250
				player.velocity.x = move_toward(player.velocity.x, 1, 200)
			else:
				player.velocity = Vector2.ZERO
