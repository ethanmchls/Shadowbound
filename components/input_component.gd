class_name InputComponent
extends Node

var input_horizontal: float = 0.0

func _process(delta) -> void:
	input_horizontal = Input.get_axis("move_left", "move_right")

func get_jump_input() -> bool:
	return Input.is_action_pressed("jump")

func get_jump_released_input() -> bool:
	return Input.is_action_just_released("jump")

func get_up_pressed() -> bool:
	return Input.is_action_pressed("move_up")

func get_down_pressed() -> bool:
	return Input.is_action_pressed("move_down")

func get_left_pressed() -> bool:
	return Input.is_action_pressed("move_left")

func get_right_pressed() -> bool:
	return Input.is_action_pressed("move_right")

func get_wall_grab_pressed() -> bool:
	return Input.is_action_pressed("wall_grab")

func get_dash_pressed() -> bool:
	return Input.is_action_just_pressed("dash")

func get_swap_pressed() -> bool:
	return Input.is_action_just_pressed("swap")

func get_dpad_direction() -> Vector2:
	return Vector2(Input.get_axis("move_left","move_right"),Input.get_axis("move_up","move_down"))
