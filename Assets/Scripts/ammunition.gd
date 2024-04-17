extends Node2D
class_name ammunition

@export var lifespan_time : float
@export var impact_detector : Area2D
@export var bullet_sprite : Sprite2D

@export var speed : float

@export var impact_particles_scene : Resource 

var direction : Vector2
var color : Color

func _ready():
	get_tree().create_timer(lifespan_time).connect("timeout", on_lifespan_timeout)
	impact_detector.connect("area_entered", on_area_hit)
	impact_detector.connect("body_entered", on_body_hit)
	color = Color(randf(), randf(), randf())
	bullet_sprite.set_modulate(color)
	direction = direction.normalized()

func on_lifespan_timeout():
	queue_free()

func _physics_process(delta):
	position += direction * speed * delta

func on_area_hit(_body):
	queue_free()

func on_body_hit(_body):
	var particles : CPUParticles2D = impact_particles_scene.instantiate()
	particles.global_position = global_position
	particles.color = color
	particles.restart()
	get_tree().root.add_child(particles)
	queue_free()
