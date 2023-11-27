@tool
class_name ScaleContainer
extends Container

@export var child_scale:Vector2 = Vector2.ONE:
	set(value):
		child_scale = value
		queue_sort()


func _get_minimum_size():
	var combined_size := Vector2.ZERO
	for child in get_children(true):
		if not (child is Control):
			continue
		var child_size = child.get_combined_minimum_size()
		combined_size = Vector2(max(combined_size.x, child_size.x), max(combined_size.y, child_size.y))

	return combined_size

func _notification(what):
	if what == NOTIFICATION_SORT_CHILDREN:
		var rect = get_rect()
		for child in get_children(true):
			if not (child is Control):
				continue
				
			fit_child_in_rect(child, rect)
			child.scale = child_scale
			
			var child_rect = child.get_rect()
			
			child.position += (rect.size - child_rect.size) / 2
			
