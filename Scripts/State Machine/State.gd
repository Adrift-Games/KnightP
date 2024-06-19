class_name State
extends Node

@export
var animation_name:String
@export
var move_speed:float =400

var gravity:float = ProjectSettings.get_setting("physics/2d/default_gravity")
## Hold a reference to the parent so that it can be controlled by the state
var parent:Player #parent set in Init function of the state machine

func enter()-> void:
	parent.animations.play(animation_name)
	
func exit ()-> void:
	pass

func process_inputs(delta)-> State:
	return null
func process_frames(delta)-> State:
	return null
func process_physics(delta)-> State:
	return null

