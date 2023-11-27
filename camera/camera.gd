extends Camera2D

var _target:Node2D

func _process(_delta):
	# try to acquire a target if none is present
	if not is_instance_valid(_target):
		var targets = get_tree().get_nodes_in_group("camera_target")
		if targets.size() == 0:
			return
	
		_target = targets[0]	
	
	position = _target.global_position
	
