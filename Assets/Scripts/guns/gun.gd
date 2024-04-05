extends Node
class_name gun

@export var shot_cooldown_time : float
@export var shoot_sfx : AudioStreamWAV

const BULLET = preload("res://Scenes/bullet.tscn")

var shot_cooldown_timer : Timer
var shot_sfx_player : AudioStreamPlayer2D

var setup : Callable = func(timer : Timer, sfx_player : AudioStreamPlayer2D):
	shot_cooldown_timer = timer
	shot_sfx_player = sfx_player
	shot_cooldown_timer.wait_time = shot_cooldown_time
	shot_sfx_player.stream = shoot_sfx

var shoot : Callable = func (last_valid_aim_dir : Vector2, bullet_position : Vector2, bullet_rotation : float):
	if (shot_cooldown_timer.is_stopped()):
		shot_sfx_player.pitch_scale = randf_range(0.4, 4)
		shot_sfx_player.play()
		shot_cooldown_timer.start()
		var bullet = BULLET.instantiate()
		bullet.position = bullet_position
		bullet.rotation = bullet_rotation
		bullet.direction = last_valid_aim_dir.normalized()
		get_tree().root.add_child(bullet)
