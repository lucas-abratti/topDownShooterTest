extends CharacterBody2D

@export var move_speed : float
@export var acceleration_speed : float
@export var deacceleration_speed : float
@export var max_speed : float

@onready var hand_root = $hand_root
@onready var hand_sprite = $hand_root/hand_sprite
@onready var expression_sprite = $expression_sprite
@onready var shot_sfx = $shot_sfx
@onready var gun = $gun
@onready var shot_cooldown_timer = $shot_cooldown_timer

const IDLE_FACE = preload("res://Assets/Sprites/face_f.png")
const SHOOTING_FACE = preload("res://Assets/Sprites/face_g.png")

var move_dir : Vector2
var last_dir : Vector2

var aim_dir : Vector2
var last_valid_aim_dir : Vector2
var last_mouse_pos : Vector2

var current_speed : float

func _ready():
	if (gun != null):
		gun.setup.call(shot_cooldown_timer, shot_sfx)

func _process(delta):
	movement(delta)
	aiming()
	shooting()

func shooting():
	if (Input.is_action_pressed("shoot")):
		gun.shoot.call(last_valid_aim_dir, hand_sprite.global_position, hand_root.rotation)
		expression_sprite.texture = SHOOTING_FACE
		expression_sprite.texture = IDLE_FACE

func aiming():
	aim_dir = Vector2.ZERO
	if (Input.is_action_pressed("aim_up")):
		aim_dir.y -= Input.get_action_raw_strength("aim_up")
	if (Input.is_action_pressed("aim_down")):
		aim_dir.y += Input.get_action_raw_strength("aim_down")
	if (Input.is_action_pressed("aim_right")):
		aim_dir.x += Input.get_action_raw_strength("aim_right")
	if (Input.is_action_pressed("aim_left")):
		aim_dir.x -= Input.get_action_raw_strength("aim_left")
	
	
	if (aim_dir == Vector2.ZERO && last_mouse_pos != get_global_mouse_position()):
		aim_dir = get_local_mouse_position()
		last_mouse_pos = aim_dir
	
	if(aim_dir != Vector2.ZERO):
		last_valid_aim_dir = aim_dir
	
	hand_root.look_at(hand_root.global_position + aim_dir)
	
	if (hand_root.global_rotation > -1 * PI/2 && hand_root.global_rotation < PI/2 ):
		hand_sprite.flip_h = false
	else:
		hand_sprite.flip_h = true

func movement(delta):
	move_dir = Vector2.ZERO
	if (Input.is_action_pressed("move_up")):
		move_dir.y -= Input.get_action_raw_strength("move_up")
	if (Input.is_action_pressed("move_down")):
		move_dir.y += Input.get_action_raw_strength("move_down")
	if (Input.is_action_pressed("move_right")):
		move_dir.x += Input.get_action_raw_strength("move_right")
	if (Input.is_action_pressed("move_left")):
		move_dir.x -= Input.get_action_raw_strength("move_left")
	move_dir = move_dir.normalized()
	if(move_dir != Vector2.ZERO):
		last_dir = move_dir
		current_speed += move_speed * acceleration_speed
		current_speed = min(current_speed, max_speed)
		velocity = move_dir * current_speed * delta
	else:
		current_speed = current_speed * deacceleration_speed
		current_speed = max(current_speed, 0)
		velocity = last_dir * current_speed * delta
	move_and_slide()
