extends Node2D

@onready var area_2d = $Area2D
@onready var label = $Label

@export var item : PackedScene 

func _ready():
	item.instantiate()
	
	var gun_data : gun = item.get_script()
	
	label.hide()
	item.get_script()
	#label.text = "Pickup " + item.get_script().gun_name
	area_2d.connect("body_entered", on_body_entered)
	area_2d.connect("body_exited", on_body_exited)

func on_body_entered(body : Node2D ):
	label.show()

func on_body_exited(body : Node2D):
	body.pickup_available = true
	body.swap_to_gun = item
	label.hide()
