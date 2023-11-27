extends Node2D

@onready var _world_root:WorldRoot = %WorldRoot
@onready var _saver_loader:SaverLoader = %SaverLoader
@onready var _pause_screen = %PauseScreen

var _paused:bool = false


func _ready():
	_world_root.level_exit_reached.connect(_on_level_exit_reached)
	
	
func _on_level_exit_reached(next_level):
	_world_root.load_level_async(next_level)
	
	
func _process(_delta):
	if Input.is_action_just_pressed("pause"):
		_pause(not _paused)

			
func _pause(value:bool):
	_paused = value
	_pause_screen.visible = _paused
	get_tree().paused = _paused


## ------------------------------------------------------------------------------------

# Called when the save game button is pressed
func _on_save_game():
	print("Save game!")
	_saver_loader.save_game()
	
# Called when the load game button is pressed
func _on_load_game():
	print("Load game!")
	_saver_loader.load_game()
	# _pause(true)
	
