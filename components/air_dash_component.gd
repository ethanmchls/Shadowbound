class_name AirDashComponent
extends Node

@export_subgroup("Nodes")
@export var dash_timer: Timer
@export var dash_pause_timer: Timer
@export var dash_cooldown_timer: Timer
@export var dash_buffer_timer: Timer
@export var dash_accelerator: int = 600

var is_dashing: bool = false
var dashes_so_far: int = 0
var is_paused: bool = false
var a_prev_v: Vector2 = Vector2.ZERO
var s_prev_v: Vector2 = Vector2.ZERO

"""
This component allows a player to dash in the air
Point the joystick in any direction and press X for Xbox controller or square
for Playstation controller
Number of air dashes can be limited in the character's settings
Dash distance can be adjusted via the DASH_ACCELERATOR and the timer wait time
""" 
func handle_air_dash(alchemist: CharacterBody2D, shadow: CharacterBody2D, direction: Vector2, dash_pressed: bool, allowed_dashes: int):
	var is_on_floor = alchemist.is_on_floor() and shadow.is_on_ceiling()
	
	if not is_dashing:
		a_prev_v = alchemist.velocity
		s_prev_v = shadow.velocity

	if is_on_floor:
		dashes_so_far = 0

	if dash_pressed and direction == Vector2.ZERO:
		dash_buffer_timer.start()

	if (not dash_buffer_timer.is_stopped() and direction != Vector2.ZERO) \
	or (not is_on_floor and dash_pressed and dashes_so_far < allowed_dashes \
	and direction != Vector2.ZERO and dash_cooldown_timer.is_stopped()):
		dash(alchemist, shadow, direction)

	if dash_timer.is_stopped() and is_dashing:
		dash_pause_timer.start()
		alchemist.velocity = Vector2(a_prev_v.x, 0.0)
		shadow.velocity = Vector2(s_prev_v.x, 0.0)
		is_dashing = false
		is_paused = true

	#if not dash_pause_timer.is_stopped() and is_paused:
		#alchemist.velocity = Vector2.ZERO

	if dash_pause_timer.is_stopped() and is_paused:
		is_paused = false

func dash(alchemist: CharacterBody2D, shadow: CharacterBody2D, direction: Vector2, ):
	var inverted_direction = Vector2(direction.x, -direction.y)

	#AudioManager.play_shadow_dash()
	dashes_so_far += 1
	is_dashing = true
	dash_timer.start()
	dash_cooldown_timer.start()
	dash_buffer_timer.stop()
	alchemist.velocity = direction * dash_accelerator
	shadow.velocity = inverted_direction * dash_accelerator
