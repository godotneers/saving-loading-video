extends Sprite2D

func _process(_delta):
	material.set_shader_parameter("time_scale", 0 if get_tree().paused else 1)
