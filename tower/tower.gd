extends Node2D

# emitted when the player earns score by hitting this
signal score_earned(score:int)

@export var ammo:PackedScene
@export var cooldown:float = 2.5
@export var max_health:float = 300
@export var points:int = 25

@onready var _ammo_spawn_point:Marker2D = %AmmoSpawnPoint
@onready var _health_indicator:Sprite2D = %HealthIndicator
@onready var _animation_player:AnimationPlayer = %AnimationPlayer
@onready var _collision_shape:CollisionShape2D = %CollisionShape


@onready var _health:float = max_health:
	set(value):
		_health = value
		_health_indicator.material.set_shader_parameter("progress", _health / max_health)
		

var _cooldown:float = 0
var _is_dying:bool = false
var _current_enemy:Node2D = null
var _last_enemy_position:Vector2


func take_damage(amount:float):
	if _is_dying:
		return
	
	_health -= amount
	if _health <= 0:
		_die()

func game_ended():
	queue_free()




func _ready():
	if not is_instance_valid(ammo):
		push_error("Tower has no ammo set!")
		set_physics_process(false)
	

func _physics_process(delta):
	if _is_dying:
		return
	
	_cooldown -= delta

	if not is_instance_valid(_current_enemy):
		return
		
	var angle = get_angle_to(_current_enemy.global_position)
	rotate(PI * angle * delta)
	
	# health indicator does not rotate with us
	_health_indicator.global_rotation = 0
	
	if _cooldown > 0:
		_last_enemy_position = _current_enemy.global_position
		return
		
	if abs(get_angle_to(_current_enemy.global_position)) > deg_to_rad(20):
		_last_enemy_position = _current_enemy.global_position
		return # only fire when having a suitable angle
		
	# calculate where the enemy will be
	var distance = _ammo_spawn_point.global_position.distance_to(_current_enemy.global_position)
	var new_ammo = ammo.instantiate()

	# given the speed of the ammo, determine how long the ammo will travel
	var travel_time = distance / new_ammo.speed
	
	# if the enemy is moving, try to extrapolate where the enemy will be
	var enemy_direction = _current_enemy.global_position - _last_enemy_position
	var target_point = _current_enemy.global_position
	if enemy_direction.length_squared() > 0:
		target_point = travel_time * enemy_direction.normalized() + _current_enemy.global_position

	new_ammo.direction = target_point - _ammo_spawn_point.global_position
	get_parent().add_child(new_ammo)
	new_ammo.global_position = _ammo_spawn_point.global_position
	
	_cooldown = cooldown

## Plays the death animation and awards points.
func _die():
	_is_dying = true
	score_earned.emit(points)
	_collision_shape.set_deferred("disabled", true)
	_animation_player.play("explode")
	await _animation_player.animation_finished
	queue_free()



func _on_enemy_entered(body):
	_current_enemy = body


func _on_enemy_exited(_body):
	_current_enemy = null


func on_before_load():
	queue_free()
