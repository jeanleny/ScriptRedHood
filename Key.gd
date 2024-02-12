extends Area2D
signal key

func _ready():
	$AnimationPlayer.play("Key_idle")




func _on_body_entered(body):
	if body.name == ("CharacterBody2D") :
		queue_free()
		key.emit()
		
		
	
	
