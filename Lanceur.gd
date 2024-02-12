extends StaticBody2D
class_name Lanceurs

var pos: Vector2 = Vector2.ZERO
signal fleche(pos)
#func _ready():
	#pos = Vector2(1848,447)
	#global_position = pos

func _on_timer_timeout():
	var fleche_marker = $FlecheLaunch 
	fleche.emit(fleche_marker.global_position)
