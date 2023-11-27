@tool

extends GPUParticles2D

@export var size_min:float = 0.02:
	set(value):
		size_min = value
		_apply_values()
		
@export var size_max:float = 0.05:
	set(value):
		size_max = value
		_apply_values()
		
		
func _ready():
	_apply_values()
		
func _apply_values():
	process_material.scale_min = size_min
	process_material.scale_max = size_max
