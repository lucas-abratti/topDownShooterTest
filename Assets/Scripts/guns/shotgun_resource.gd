extends gun

func _ready():
	shoot = override_shoot

var override_shoot : Callable = func (last_valid_aim_dir : Vector2, bullet_position : Vector2, bullet_rotation : float):
	if (shot_cooldown_timer.is_stopped()):
		shot_sfx_player.pitch_scale = randf_range(0.4, 4)
		shot_sfx_player.play()
		shot_cooldown_timer.start()
		for i in 4:
			var randomRotation = randf_range(-PI/15, PI/15) # Adjust the range as needed
			var rotatedDirection = last_valid_aim_dir.rotated(randomRotation)
			var bullet = bullet_scene.instantiate()
			bullet.position = bullet_position
			bullet.rotation = bullet_rotation
			bullet.direction = rotatedDirection
			get_tree().root.add_child(bullet)
