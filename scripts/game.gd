extends Node2D

@export var alchemist: Node2D
@export var shadow: Node2D

@export_subgroup("Nodes")
@export var gravity_component: GravityComponent
@export var input_component: InputComponent
@export var movement_component: MovementComponent
@export var jump_component: JumpComponent
@export var fast_fall_component: FastFallComponent
@export var air_dash_component: AirDashComponent
@export var wall_climb_component: WallClimbComponent
@export var animation_component: AnimationComponent
@export var swap_component: SwapComponent

@export_subgroup("Settings")
@export var allowed_jumps: int = 2
@export var allowed_air_dashes: int = 1
@export var shadow_jump_multiplier: float = 1.3

func _physics_process(delta):
	var is_jumping = input_component.get_jump_input()
	var is_jump_released = input_component.get_jump_released_input()
	var is_dashing = input_component.get_dash_pressed()
	var is_up_pressed = input_component.get_up_pressed()
	var is_down_pressed = input_component.get_down_pressed()
	var is_left_pressed = input_component.get_left_pressed()
	var is_right_pressed = input_component.get_right_pressed()
	var is_wall_grab_pressed = input_component.get_wall_grab_pressed()
	var is_swap_pressed = input_component.get_swap_pressed()
	var dpad_direction = input_component.get_dpad_direction()

	gravity_component.handle_gravity(alchemist, shadow, delta)
	movement_component.handle_horizontal_movement(alchemist, shadow, input_component.input_horizontal)
	jump_component.handle_jump(alchemist, shadow, is_jumping, is_down_pressed, allowed_jumps, gravity_component.max_fall_velocity, shadow_jump_multiplier)
	fast_fall_component.handle_fast_fall(alchemist, shadow, is_down_pressed, is_up_pressed)
	wall_climb_component.handle_wall_grab(alchemist, is_wall_grab_pressed, is_up_pressed, is_down_pressed, is_jumping, is_left_pressed, is_right_pressed)
	animation_component.handle_h_flip(input_component.input_horizontal)
	animation_component.handle_v_flip()
	animation_component.handle_jump_animation(jump_component.is_ascending, jump_component.is_descending)
	if alchemist.is_on_floor():
		animation_component.handle_move_animation(input_component.input_horizontal, jump_component.is_ascending, jump_component.is_descending)
	swap_component.handle_swap(alchemist, shadow, is_swap_pressed)
	
	if not Global.is_frozen:
		alchemist.move_and_slide()
		shadow.move_and_slide()
	#print(alchemist.position)
	
	# Lock shadow and alchemist to each other's x positions
	if shadow.is_on_wall():
		alchemist.position.x = shadow.position.x
	else:
		shadow.position.x = alchemist.position.x

func _on_jump_component_player_jumped():
	emit_signal("player_jumped")
