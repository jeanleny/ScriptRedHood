extends Node2D

var fleche_bas_scene : PackedScene = preload("res://lEVEL/Projectiles/fleche_BAS.tscn")
var fleche_droite_scene : PackedScene = preload("res://lEVEL/Projectiles/fleche_droite.tscn")
#var pos : Vector2 = Vector2.ZERO
#
#
func _on_lanceur_fleche(pos):
	var fleche_bas = fleche_bas_scene.instantiate()
	add_child(fleche_bas)
	fleche_bas.position = pos


func _on_lanceur_droite_fleche(pos):
	var fleche_droite = fleche_droite_scene.instantiate()
	add_child(fleche_droite)
	fleche_droite.position = pos
	
