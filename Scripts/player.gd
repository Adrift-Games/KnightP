
extends CharacterBody2D

enum state{GROUNDED,AIRBORNE,SLIDING,NULL=-1}

@onready var animated_sprite_2d = $AnimatedSprite2D
@onready var state_debug = $StateDebug


@export var SPEED =150.0
@export var JUMP_VELOCITY = -300.0


var PlayerStates:state 	
# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _ready():
	PlayerStates=state.NULL

func _physics_process(delta):
	# Add the gravity.
	var direction = Input.get_axis("move_right","move_left")
	
	update_PlayerStates()
	
	match PlayerStates:
		state.GROUNDED:
			handle_GroundedInputs(delta,direction)
		state.AIRBORNE:
			hande_AirborneInputs(delta) 
	
	handle_animations(direction)	
	
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	
	
	

	move_and_slide()
	
	
func update_PlayerStates():
	if not is_on_floor():
		PlayerStates=state.AIRBORNE
	else:
		PlayerStates=state.GROUNDED
		
	state_debug.text= str(PlayerStates)

func handle_GroundedInputs(delta,direction):
	
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		
	if Input.is_action_just_pressed("jump"):
		velocity.y = JUMP_VELOCITY
	
	
func hande_AirborneInputs(delta):
	velocity.y += gravity * delta
	
func handle_animations(direction:float):
	
	if direction < 0:
		animated_sprite_2d.flip_h= true
	else:
		animated_sprite_2d.flip_h=false
	
	if (velocity.x < 0.01 and velocity.x > -0.01 and PlayerStates==state.GROUNDED):
		animated_sprite_2d.play("Idle")
	else:
		animated_sprite_2d.play("Running")
	
