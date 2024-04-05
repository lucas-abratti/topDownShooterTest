extends Node2D

@onready var lifespan_timer = $lifespan_timer
@onready var impact_detector = $impact_detector
@onready var bullet_sprite = $bullet_sprite

@export var speed : float

const IMPACT_PARTICLES = preload("res://Scenes/impact_particles.tscn")

var direction : Vector2
var color : Color

func _ready():
	lifespan_timer.connect("timeout", on_lifespan_timeout)
	impact_detector.connect("area_entered", on_area_hit)
	impact_detector.connect("body_entered", on_body_hit)
	color = Color(randf(), randf(), randf())
	bullet_sprite.set_modulate(color)

func on_lifespan_timeout():
	queue_free()

func _physics_process(delta):
	position += direction * speed * delta

func on_area_hit(_body):
	queue_free()

func on_body_hit(_body):
	var particles : CPUParticles2D = IMPACT_PARTICLES.instantiate()
	particles.global_position = global_position
	particles.color = color
	particles.restart()
	get_tree().root.add_child(particles)
	queue_free()
