
extends CharacterBody2D

@onready var animated_sprite_2d = $AnimatedSprite2D


@export var max_speed:float =250.0
@export var max_air_speed:float =250

@export var max_falling_speed:float = 400

@export var jump_velocity:float = -400.0
@export var variable_jump_downwards_force:float=0.15

var acceleration:float = 750.00
var air_acceleration:float =1000.00

var friction:float = 1150.00
var air_friction:float = 1000.00
# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

var jump_buffering:int = 10 #1/4 of a second due to _physics_process iterates 60 a sec  
var jump_buffering_counter:int =0
var jump_buffer_queued:bool = false
var jump_performed:bool=false
 
var coyote_jump_buffering:int=10
var coyote_jump_counter:int = 0

var apex_threshold:float = 50
var apex_acceleration:float = 500
var apex_speed_boost:float = 2

var last_direction:int = 0
var direction_switch_speed:float =75

var airborne_jumps_tokens:int
var max_airborne_jumps:int=1

func _ready():
	airborne_jumps_tokens=max_airborne_jumps


func _physics_process(delta):
	#detect horizontal movement input --------------------------------
	var direction = Input.get_axis("move_left","move_right")
	
	if not is_on_floor():
		
		#Horizontal velocity while on air--------------------------------
		if(direction):
			velocity.x=move_toward(velocity.x,max_air_speed,direction*air_acceleration*delta)#check if player is grounded
		else:
			velocity.x = move_toward(velocity.x,0,air_friction*delta)
		
		#Apply Gravity--------------------------------
		if abs(velocity.y) < apex_threshold:
			#print("APEX")
			velocity.y+=apex_acceleration*delta

		elif is_on_wall() and velocity.y>0:
			velocity.y+=25*delta
			print(velocity.y)
			
						
		else:
			#print("GRAV")
			velocity.y+=gravity*delta
		
		#Apply Variable jump if released input early--------------------------------
		if Input.is_action_just_released("jump") and velocity.y<0:
			velocity.y*=variable_jump_downwards_force
		#Set jump buffering counter --------------------------------
		if Input.is_action_just_pressed("jump"): 
			jump_buffering_counter=jump_buffering
		
		#Double jump 
		perform_double_jump()
		
		#set Coyote jump  --------------------------------
		coyote_jump_counter-=1
		perform_jump(true,false) #perform coyote jump
		
		
	else:
		#velocity while grounded--------------------------------
		if(direction):
			velocity.x=move_toward(velocity.x,max_speed,direction*acceleration*delta)#check if player is grounded
		else:
			velocity.x = move_toward(velocity.x,0,friction*delta)
		
		#perform jump --------------------------------
		perform_jump(false,false)
		#reset coyote--------------------------------
		coyote_jump_counter=coyote_jump_buffering
		#reset airborn jumps
		airborne_jumps_tokens=max_airborne_jumps
	#Jump buffering code-----------------------------
	if jump_buffering_counter > 0:
		jump_buffering_counter -=1 
	if jump_buffering_counter >0 and is_on_floor():
		perform_jump(false,true)
		jump_buffering_counter=0
		
		
		
	handle_animations(direction)
	#comment direction switching---------------------
	if(last_direction != direction):
		if(direction!=0):
			velocity.x+=direction_switch_speed*direction
			last_direction=direction

	#Clamp velocities ----------------------------------
	velocity.x=clampf(velocity.x,-max_speed,max_speed)
	velocity.y=clampf(velocity.y,-max_falling_speed,max_falling_speed)

	#print("velocity X: ",velocity.x,"-----","velocity Y: ",velocity.y)
	move_and_slide()
	
func handle_animations(direction):
	if(direction < 0):
		animated_sprite_2d.flip_h = true
	elif (direction > 0):
		animated_sprite_2d.flip_h = false
		
	if(velocity.x == 0 and direction == 0):
		animated_sprite_2d.play("Idle")
	else:
		animated_sprite_2d.play("Running")
	
	if not is_on_floor():
		animated_sprite_2d.play("Fall")

func perform_jump(is_coyote,is_from_jumpBuffer):
			
	if not is_from_jumpBuffer:
		if Input.is_action_just_pressed("jump"):
			if not is_coyote:
				velocity.y=jump_velocity
				jump_performed=true	
			
			elif is_coyote and coyote_jump_counter>0 and jump_performed==false:
				velocity.y=jump_velocity
		else: 
			jump_performed=false
	else:
		velocity.y=jump_velocity
		jump_performed=true	

func perform_double_jump():
	if(airborne_jumps_tokens>0 and Input.is_action_just_pressed("jump")):
		velocity.y=jump_velocity
		airborne_jumps_tokens-=1
	
