class_name FastFallComponent
extends Node

@export_subgroup("Settings")
@export var quick_fall_velocity: float = 300

# Player can fast fall if down is pressed at apex
func handle_fast_fall(alchemist: CharacterBody2D, shadow: CharacterBody2D, down_pressed: bool, up_pressed: bool) -> void:
	if alchemist.velocity.y < 100.0 or shadow.velocity.y < 100.0:
		if down_pressed:
			alchemist.velocity.y = quick_fall_velocity
			shadow.velocity.y = -quick_fall_velocity
