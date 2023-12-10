class_name SaverLoader
extends Node

@onready var _player:Player = %Player as Player
@onready var _world_root:WorldRoot = %WorldRoot


func save_game():
	var saved_game := SavedGame.new()
	
	# save the path to the currently loaded level
	saved_game.level_path = _world_root.get_current_level_path()
	
	# store player health and position
	saved_game.player_health = _player.health
	saved_game.player_position = _player.global_position

	# collect all dynamic game elements	
	var saved_data:Array[SavedData] = []
	get_tree().call_group("game_events", "on_save_game", saved_data)
	
	# store them in the savegame
	saved_game.saved_data = saved_data
	
	# write the savegame to disk
	ResourceSaver.save(saved_game, "user://savegame.tres")

	
	
func load_game():
	
	# fix any paths that may be broken after a game update
	var fixed_path = PathFixer.fix_paths("user://savegame.tres")
	print("Loading from ", fixed_path )
	
	# load the savegame securely
	var saved_game:SavedGame = SafeResourceLoader.load(fixed_path) as SavedGame
	if saved_game == null:
		return
	
	# first restore the level
	# this may take a few frames, so we wait with await
	await _world_root.load_level_async(saved_game.level_path)
	
	# clear the stage
	get_tree().call_group("game_events", "on_before_load_game")
	
	# restore player position
	_player.global_position = saved_game.player_position
	# verify & restore player health
	_player.health = min(saved_game.player_health, 200)
	
	# restore all dynamic game elements	
	for item in saved_game.saved_data:
		# skip over data we don't use anymore
		if item is UnusedData:
			continue
		
		# load the scene of the saved item and create a new instance
		var scene := load(item.scene_path) as PackedScene
		var restored_node = scene.instantiate()
		# add it to the world root
		_world_root.add_child(restored_node)
		# and run any custom load logic
		if restored_node.has_method("on_load_game"):
			restored_node.on_load_game(item)
		
	
