extends Node2D

@export var speed:float = 500
@export var damage:float = 30
@export var lifetime:float = 20

var direction:Vector2 = Vector2.ONE

var _dying:bool = false


func on_save_game(saved_data:Array[SavedData]):
	if _dying:
		return
		
	var my_data = SavedTorpedoData.new()
	my_data.position = global_position
	my_data.scene_path = scene_file_path
	my_data.direction = direction
	saved_data.append(my_data)


func on_before_load_game():
	get_parent().remove_child(self)
	queue_free()

	
func on_load_game(saved_data:SavedData):
	var my_data = saved_data as SavedTorpedoData
	global_position = my_data.position
	direction = my_data.direction
	look_at(global_position + direction)
	

func _ready():
	direction = direction.normalized()
	look_at(global_position + direction)

func _physics_process(delta):
	if _dying:
		return
		
	lifetime -= delta
	if lifetime <= 0:
		explode()
	
	
	global_position = global_position + direction * speed * delta
	

func explode():
	_dying = true
	%AnimationPlayer.play("explode")
	await %AnimationPlayer.animation_finished
	visible = false
	queue_free()


func _on_detection_area_body_entered(body):
	if _dying:
		return
	
	if body.has_method("take_damage"):
		body.take_damage(damage)
		explode()


