extends Resource
class_name gun

@export var shot_cooldown_time : float
@export var shoot_sfx : AudioStreamWAV
@export var bullet_scene : Resource
@export var gun_name : String

var shot_cooldown_timer : Timer
var shot_sfx_player : AudioStreamPlayer2D

var setup : Callable = func(timer : Timer, sfx_player : AudioStreamPlayer2D):
	shot_cooldown_timer = timer
	shot_sfx_player = sfx_player
	shot_cooldown_timer.wait_time = shot_cooldown_time
	shot_sfx_player.stream = shoot_sfx
	
	bullet_scene = load(bullet_scene.resource_path)

var shoot : Callable = func (last_valid_aim_dir : Vector2, bullet_position : Vector2, bullet_rotation : float) -> Node:
	if (shot_cooldown_timer.is_stopped()):
		shot_sfx_player.pitch_scale = randf_range(0.4, 4)
		shot_sfx_player.play()
		shot_cooldown_timer.start()
		var bullet = bullet_scene.instantiate()
		bullet.position = bullet_position
		bullet.rotation = bullet_rotation
		bullet.direction = last_valid_aim_dir.normalized()
		return bullet
	return null
