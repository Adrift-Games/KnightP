extends Node2D


@onready var animated_sprite_2d = $AnimatedSprite2D
@onready var raycast_left = $Raycast_Left
@onready var raycast_right = $Raycast_Right


@export var speed:float = 20.00

var direction:float =1
var awaken:bool = false

func _process(delta):
	begin_movement(delta)
	
	


func _on_detection_area_body_entered():#Detection area 
	print("player detected")
	animated_sprite_2d.play("Wake")
	
func _on_hurt_box_body_entered():
	print("player hit")

func _on_animated_sprite_2d_animation_finished():
	if(awaken == false):
		print("Set movement")
		awaken=true

		

func begin_movement(delta):
	if(raycast_left.is_colliding()):
		print("colling left")
		direction= 1
		animated_sprite_2d.flip_h = false
	
	if(raycast_right.is_colliding()):
		print("colling right")
		direction =-1
		animated_sprite_2d.flip_h = true
		
	position.x+=direction*speed*delta
	
	
