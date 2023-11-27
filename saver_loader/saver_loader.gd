class_name SaverLoader
extends Node

@onready var _player:Player = %Player as Player
@onready var _world_root = %WorldRoot


func save_game():
	var saved_game := SavedGame.new()
	
	saved_game.player_health = _player.health
	saved_game.player_position = _player.global_position
	
	
	var saved_data:Array[SavedData] = []
	get_tree().call_group("game_events", "on_save_game", saved_data)
	
	saved_game.saved_data = saved_data
	
	ResourceSaver.save(saved_game, "user://savegame.tres")

	
	
func load_game():
	var fixed_path = PathFixer.fix_paths("user://savegame.tres")
	print("Loading from ", fixed_path )
	
	var saved_game:SavedGame = SafeResourceLoader.load(fixed_path) as SavedGame
	if saved_game == null:
		return
	
	_player.global_position = saved_game.player_position
	# verify player health
	_player.health = min(saved_game.player_health, 200)
	
	get_tree().call_group("game_events", "on_before_load_game")
	
	for item in saved_game.saved_data:
		# skip over data we don't use anymore
		if item is UnusedData:
			continue
		
		var scene := load(item.scene_path) as PackedScene
		var restored_node = scene.instantiate()
		_world_root.add_child(restored_node)
		if restored_node.has_method("on_load_game"):
			restored_node.on_load_game(item)
		
	
