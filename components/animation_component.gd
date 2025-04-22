class_name AnimationComponent
extends Node

var player: AnimatedSprite2D
var shadow: AnimatedSprite2D

func _ready():
	player = $"../../Player/Alchemist/AnimatedSprite2D"
	shadow = $"../../Player/Shadow/AnimatedSprite2D"

func handle_h_flip(move_direction: float) -> void:
	if move_direction == 0:
		return

	player.flip_h = true if move_direction < 0 else false
	shadow.flip_h = true if move_direction < 0 else false

func handle_v_flip() -> void:
	var is_swapped = Global.is_inverted
	player.flip_v = true if is_swapped else false
	shadow.flip_v = false if is_swapped else true

func handle_move_animation(move_direction: float, is_jumping: bool, is_falling: bool) -> void:
	handle_h_flip(move_direction)
	
	if move_direction != 0:
		player.play("run")
		shadow.play("run")
		pass
	else:
		player.play("idle")
		shadow.play("idle")

func handle_jump_animation(is_jumping: bool, is_falling: bool) -> void:
	#if is_jumping:
		#player.play("jump")
		#shadow.play("jump")
	if is_falling:
		player.play("fall")
		shadow.play("fall")

func handle_ledge_grab_animation(is_on_ledge: bool):
	pass

func handle_ledge_climb_animation(is_ledge_climbing: bool):
	pass

func handle_ledge_jump_animation(is_ledgejumping: bool):
	pass
