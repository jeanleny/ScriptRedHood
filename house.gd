extends Area2D
signal zoom_cam

func _on_body_entered(body):
	zoom_cam.emit()
	if Global.got_key :
		$Closed_House.modulate.a = 0
	
