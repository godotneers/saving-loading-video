class_name WorldRoot
extends Node2D

signal level_exit_reached(next_level:String)


func load_level_async(path:String):
	# wait a physics frame so we can modify the tree
	await get_tree().physics_frame
	get_tree().paused = true
	
	# load the next level
	var next_level:Level = load(path).instantiate()
	next_level.exit_reached.connect(_on_level_exit_reached)
	
	# kill everything below the world root
	for child in get_children():
		if not child.is_in_group("world_root_no_touch"):
			remove_child(child)
			child.queue_free()
		
	# instantiate the new level
	# add to world root
	add_child(next_level)

	# move any other nodes to front so they render above the level
	for child in get_children():
		if child.is_in_group("world_root_no_touch"):
			child.move_to_front()
	

	get_tree().paused = false
	# connect the signal to get notified when the exit is reached

	
func _on_level_exit_reached(next_level:String):
	level_exit_reached.emit(next_level)


