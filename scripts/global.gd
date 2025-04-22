extends Node

var is_inverted: bool
var is_frozen: bool

# Called when the node enters the scene tree for the first time.
func _ready():
	is_inverted = false
	is_frozen = false

func invert():
	is_inverted = not is_inverted

func freeze():
	is_frozen = true

func unfreeze():
	is_frozen = false
