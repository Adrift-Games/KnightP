
extends CharacterBody2D

@onready var animated_sprite_2d = $AnimatedSprite2D


@export var speed =150.0
@export var jump_velocity = -300.0
var max_speed:float = 250.00
var acceleration:float = 700.00
var friction:float = 1000.00
# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _ready():
	pass


func _physics_process(delta):
	#detect horizontal movement input 
	var direction = Input.get_axis("move_left","move_right")
	
	if(direction):
		velocity.x=move_toward(velocity.x,max_speed,direction*acceleration*delta)
	else:
		velocity.x = move_toward(velocity.x,0,friction*delta)

	if(abs(velocity.x) > max_speed):
			velocity.x =max_speed * direction
	
	#Flip sprite depending on direction
	if(direction < 0):
		animated_sprite_2d.flip_h = true
	elif (direction > 0):
		animated_sprite_2d.flip_h = false
	
	print(velocity.x)
	move_and_slide()
	
