extends Node

#reference to the Entity 
@export
var starting_State:State
var current_state:State 


func init(parent:CharacterBody2D)-> void:
	for child:State in get_children():
		child.parent=parent
		
	change_state(starting_State)
	
func change_state(new_state:State)-> void:
	#COMMENT: if the player is in a state, exit
	if current_state: 
		current_state.exit()
	current_state=new_state
	current_state.enter()



##COMMENT: each process function (process_inputs,process_physics,process_frames)
## within states return the state to transition 

func process_inputs(event:InputEvent)-> void:

	var new_state:State = current_state.process_inputs(event) 
	if new_state:
		change_state(new_state)
	

func process_physics(delta:float)-> void:
	var new_state:State = current_state.process_physics(delta)
	if new_state:
		change_state(new_state)
	
	
func process_frames(delta:float)-> void:
	var new_state:State = current_state.process_frames(delta)
	if new_state:
		change_state(new_state)
