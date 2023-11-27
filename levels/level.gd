class_name Level
extends Node2D

signal exit_reached(next_level:String)

# We don't export a packed scene here to avoid circular references between scenes.
@export_file("*.tscn") var next_level:String

func _ready():
	if exit_reached.get_connections().size() == 0:
		push_warning(get_path(), " exit_reached is not connected, this doesn't look right.")
	
	var level_exits = get_tree().get_nodes_in_group("level_exit")
	for exit in level_exits:
		exit.exit_reached.connect(_on_exit_reached)
		
func _on_exit_reached():
	exit_reached.emit(next_level)

