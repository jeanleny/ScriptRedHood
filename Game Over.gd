extends Control



func _on_try_again_pressed():
	get_tree().change_scene_to_file("res://lEVEL/Niveau.tscn")


func _on_quit_pressed():
	get_tree().quit()
