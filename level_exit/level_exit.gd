extends Node2D

signal exit_reached()

func _on_detection_area_body_entered(_body):
	exit_reached.emit()
