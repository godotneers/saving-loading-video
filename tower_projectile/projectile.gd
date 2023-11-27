extends Node2D

@export var speed:float = 500
@export var damage:float = 30
@export var lifetime:float = 20

var direction:Vector2 = Vector2.ONE

var _dying:bool = false


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


