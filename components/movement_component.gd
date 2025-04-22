class_name MovementComponent
extends Node

@export_subgroup("Settings")
@export var speed: float = 200.0
@export var ground_accel_speed: float = 150.0
@export var ground_decel_speed: float = 100.0
@export var air_accel_speed: float = 50.0
@export var air_decel_speed: float = 50.0

func handle_horizontal_movement(alchemist: CharacterBody2D, shadow: CharacterBody2D, direction: float):
	var velocity_change_speed: float = 0.0
	if alchemist.is_on_floor() or shadow.is_on_ceiling():
		velocity_change_speed = ground_accel_speed if direction != 0 else ground_decel_speed
	else:
		velocity_change_speed = air_accel_speed if direction != 0 else air_decel_speed

	if (alchemist.is_on_wall() and alchemist.is_on_floor()) or not alchemist.is_on_wall():
		alchemist.velocity.x = move_toward(alchemist.velocity.x, direction * speed, velocity_change_speed)
		shadow.velocity.x = move_toward(shadow.velocity.x, direction * speed, velocity_change_speed)
