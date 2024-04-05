extends Camera2D

@export var target_a : Node2D
@export var target_b : Node2D

var current_target : Node2D 

func _ready():
	current_target = target_a

func _process(_delta):
	global_position = lerp(global_position, current_target.global_position, 0.02)

func _input(event):
	if(Input.is_action_just_pressed("precision_aim")):
		if(current_target == target_a):
			current_target = target_b
		else:
			current_target = target_a
