class_name GameOverSign
extends MarginContainer

@onready var _animation_player:AnimationPlayer = %AnimationPlayer

func reveal():
	visible = true
	_animation_player.play("reveal")
	
func conceal():
	_animation_player.play("conceal")
	
