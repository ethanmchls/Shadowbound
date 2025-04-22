class_name GravityComponent
extends Node

@export_subgroup("Settings")
@export var gravity: float = 1200.0
@export var max_fall_velocity: float = 450

func handle_gravity(alchemist: CharacterBody2D, shadow: CharacterBody2D, delta: float) -> void:
	var is_swapped = Global.is_inverted
	var a_gravity = -1 if is_swapped else 1
	var s_gravity = 1 if is_swapped else -1
	if not alchemist.is_on_floor() or alchemist.velocity.y < max_fall_velocity:
		alchemist.velocity.y += a_gravity * gravity * delta
	if not shadow.is_on_ceiling() or shadow.velocity.y > max_fall_velocity:
		shadow.velocity.y += s_gravity * gravity * delta
