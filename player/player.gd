class_name Player
extends CharacterBody2D

signal died()

@export var speed:float = 200
@export var rotation_speed:float = PI
@export var max_health:float = 100
@export var cooldown:float = 0.9
@export var ammo:PackedScene
@export var world_root:NodePath

@onready var _projectile_spawn_point:Node2D = %ProjectileSpawnPoint
@onready var _sprite:Sprite2D = %Sprite2D

@onready var health:float = max_health:
	set(value):
		health = value
		_refresh_health()

var _dying = false
var _cooldown:float = 0
var _world_root:Node2D = null

func _ready():
	_world_root = get_node(world_root)
	_refresh_health()

func take_damage(damage:float):
	if _dying:
		return
		
	health = max(0, health-damage)	
	
	if health <= 0:
		_explode()

func _explode():
	_dying = true
	died.emit()
	queue_free()

func _refresh_health():
	if is_instance_valid(_sprite):
		_sprite.material.set_shader_parameter("health_percent", health / max_health)


func _physics_process(delta):
	_cooldown -= delta
	
	var horizontal = Input.get_axis("left", "right")
	var vertical = Input.get_axis("up", "down")
	
	velocity = Vector2(horizontal, vertical) * speed
	move_and_slide()
	
	if Input.is_action_pressed("fire") and _cooldown <= 0:
		# reset cooldown
		_cooldown = cooldown
		var new_projectile = ammo.instantiate()
		new_projectile.global_position = _projectile_spawn_point.global_position
		new_projectile.direction = _projectile_spawn_point.global_position - global_position
		_world_root.add_child(new_projectile)
	

