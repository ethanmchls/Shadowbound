class_name JumpComponent
extends Node

@export_subgroup("Nodes")
@export var jump_buffer_timer: Timer
@export var coyote_timer: Timer
@export var jump_cooldown_timer: Timer

@export_subgroup("Settings")
@export var jump_velocity: float = -250.0

signal player_jumped

var is_ascending: bool = false
var is_descending: bool = false
var is_jumping: bool = false
var last_frame_on_floor: bool = false
var jumps_so_far: int = 0
var is_on_floor: bool

func has_just_landed(alchemist: CharacterBody2D) -> bool:
	return is_on_floor and not last_frame_on_floor and is_jumping

func has_just_stepped_off_ledge(alchemist: CharacterBody2D) -> bool:
	return not is_on_floor and last_frame_on_floor and not is_jumping

func can_jump(alchemist: CharacterBody2D, jump_pressed: bool, allowed_jumps: int) -> bool:
	if is_on_floor:
		jumps_so_far = 0
	return jump_pressed and jump_cooldown_timer.is_stopped() and ((is_on_floor or (is_on_floor and alchemist.is_on_wall())) or (not coyote_timer.is_stopped() or jumps_so_far < allowed_jumps))

func handle_jump(alchemist: CharacterBody2D, shadow: CharacterBody2D, jump_pressed: bool, down_pressed: bool, allowed_jumps: int, max_fall_velocity: float, shadow_jump_multiplier: float) -> void:
	is_on_floor = alchemist.is_on_floor() and shadow.is_on_ceiling()

	if has_just_landed(alchemist):
		is_jumping = false

	if can_jump(alchemist, jump_pressed, allowed_jumps):
		jump(alchemist, shadow, shadow_jump_multiplier)

	handle_coyote_time(alchemist)
	handle_jump_buffer(alchemist, shadow, jump_pressed, shadow_jump_multiplier)
	handle_jump_cancel(alchemist, shadow, down_pressed)
	handle_short_jump(alchemist, shadow, jump_pressed)
	#handle_fast_fall(alchemist, down_pressed, down_released, max_fall_velocity)

	is_ascending = alchemist.velocity.y < 0 and not is_on_floor
	is_descending = alchemist.velocity.y > 0 and not is_on_floor
	last_frame_on_floor = is_on_floor

func handle_coyote_time(alchemist: CharacterBody2D) -> void:
	if has_just_stepped_off_ledge(alchemist):
		coyote_timer.start()

	if not coyote_timer.is_stopped() and not is_jumping:
		alchemist.velocity.y = 0

func handle_jump_buffer(alchemist: CharacterBody2D, shadow: CharacterBody2D, jump_pressed: bool, shadow_jump_multiplier: float) -> void:
	if jump_pressed and not is_on_floor:
		jump_buffer_timer.start()

	if is_on_floor and not jump_buffer_timer.is_stopped():
		jump(alchemist, shadow, shadow_jump_multiplier)

# Player can jump cancel if still ascending
func handle_jump_cancel(alchemist: CharacterBody2D, shadow: CharacterBody2D, down_pressed: bool) -> void:
	if down_pressed and is_ascending:
		alchemist.velocity.y = 0
		shadow.velocity.y = 0

func handle_short_jump(alchemist: CharacterBody2D, shadow: CharacterBody2D, jump_pressed: bool) -> void:
	pass
	#if is_ascending and not jump_pressed:
		#alchemist.velocity.y = 0
		#shadow.velocity.y = 0

func jump(alchemist: CharacterBody2D, shadow: CharacterBody2D, shadow_jump_multiplier: float) -> void:
	var alchemist_animated_sprite = $"../../Player/Alchemist/AnimatedSprite2D"
	var shadow_animated_sprite = $"../../Player/Shadow/AnimatedSprite2D"
	alchemist_animated_sprite.play("jump")
	shadow_animated_sprite.play("jump")
	#AudioManager.play_jump_sound()
	jump_cooldown_timer.start()
	jumps_so_far += 1
	alchemist.velocity.y = jump_velocity
	shadow.velocity.y = -jump_velocity * shadow_jump_multiplier
	jump_buffer_timer.stop()
	is_jumping = true
	coyote_timer.stop()
