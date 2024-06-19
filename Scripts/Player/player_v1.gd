
class_name Player
extends CharacterBody2D

@onready
var animations=$Animations
@onready
var state_machine=$State_machine

func _ready() -> void:
	#initialize state machine
	state_machine.init(self)
	

func _unhandled_input(event:InputEvent)-> void:
	#delegate to state machine
	state_machine.process_inputs(event)
	

func _physics_process(delta:float)-> void:
	#delegate to state machine
	state_machine.process_physics(delta)

func _process(delta:float)-> void:
	#delegate to state machine
	state_machine.process_frames(delta)
