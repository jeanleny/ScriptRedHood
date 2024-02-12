extends CanvasLayer


func _ready():
	$"Clé/IconeClef".modulate.a = 0
	update_health()
	Global.connect("health_change", update_health)
	
func _process(_delta):
	update_health()
	
func end():
	$AnimationPlayer.play("Fondu")
	await $AnimationPlayer.animation_finished
	get_tree().change_scene_to_file("res://Menu/credits.tscn")

func update_health():
	$"Barre de Santé/TextureProgressBar".value = Global.health

func _on_area_2d_key():
	$"Clé/IconeClef".modulate.a = 1
	Global.got_key = true
	$AudioStreamPlayer.play()

func _on_character_body_2d_ending():
	end()
