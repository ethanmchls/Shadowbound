class_name SwapComponent
extends Node

func handle_swap(player: CharacterBody2D, shadow: CharacterBody2D, swap_pressed: bool):
	var p_y_pos = player.position.y
	var s_y_pos = shadow.position.y
	
	#print(str(p_y_pos) + " " + str(s_y_pos))
	#print(str(player.position) + " " + str(shadow.position))

	if p_y_pos > 285.0 and s_y_pos < 350.0 and swap_pressed:
		print("pos x" + str(player.position) + " " + str(shadow.position))
		#is_flipped = not is_flipped
		##print("swap")
		#var tmp = player.global_position
		##print("temp" + str(tmp))
		#player.global_position = shadow.global_position
		#shadow.global_position = tmp
		##print("after" + str(player.position) + " " + str(shadow.position))
		#shadow.velocity = Vector2.ZERO
		#player.velocity = Vector2.ZERO
		#var p_pos = player.position
		#var s_pos = shadow.position
		
		var tmp = player.position
		Global.freeze()
		player.position = shadow.position
		player.velocity = Vector2.ZERO
		shadow.position = tmp
		shadow.velocity = Vector2.ZERO
		#player.position.x += 20
		Global.invert()
		shadow.position.x += 20
		Global.unfreeze()
