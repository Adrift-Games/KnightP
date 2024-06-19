extends State

@export
var jump_state: State 


# Called when the node enters the scene tree for the first time.
func enter():
	print("current_state: IDLE")
	super()
	parent.velocity.x=0 


func process_frames(delta:float)-> State:
	return null

func process_inputs(event:InputEvent)-> State:
	
	if(Input.is_action_just_pressed("jump")):
		return jump_state
	
	return null
	
	
func process_physics(delta:float)->State:
	parent.velocity.y+=gravity*delta
	parent.move_and_slide()
	
	if(!parent.is_on_floor()):
		return null
	
	return null
	
