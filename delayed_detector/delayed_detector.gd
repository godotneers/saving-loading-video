extends Area2D


func _ready():
	# delay enabling the detection area to avoid having spurious overlaps with the 
	# player when loading a new level
	await get_tree().physics_frame
	await get_tree().physics_frame
	monitoring = true
	monitorable = true

