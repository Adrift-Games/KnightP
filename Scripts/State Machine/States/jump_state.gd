extends State

@export
var fall_state: State
@export
var idle_state: State

# Called when the node enters the scene tree for the first time.
func enter():
	print("current_state: JUMP")
	super()
	parent.velocity.x=0 
	parent.velocity.y=-300


func process_frames(delta:float)-> State:
	return null

func process_inputs(event:InputEvent)-> State:
	return null
	
	
func process_physics(delta:float)->State:
	parent.move_and_slide()
	return null
	
