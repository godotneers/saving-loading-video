extends CharacterBody2D
@export var speed:float = 200
@export var impact_damage:float = 50

@onready var _sprite:Sprite2D = %Sprite2D
@onready var _animation_player = %AnimationPlayer

var _target:Node2D
var _dying:bool = false

func _physics_process(_delta):
	if not is_instance_valid(_target) or _dying:
		return
		
	velocity = (_target.global_position - global_position).normalized() * speed
	_sprite.flip_h = velocity.x < 0
	move_and_slide()
	
	var collision_count = get_slide_collision_count()
	for i in collision_count:
		if _dying:
			return
		
		var collision_info = get_slide_collision(i)
		var collider = collision_info.get_collider()
		
		if collider.has_method("take_damage"):
			collider.take_damage(impact_damage)
			_die()



func take_damage(_damage:float):
	_die()
		
		
func _die():
	_dying = true
	_animation_player.play("explode")
	await _animation_player.animation_finished
	visible = false
	queue_free()


func _on_detection_area_body_entered(body):
	if body.is_in_group("player"):
		_target = body
