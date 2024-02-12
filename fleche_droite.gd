extends fleches

var droite : Vector2 = Vector2.RIGHT

func _physics_process(delta):
	position += droite * speed * delta
	

func _on_body_entered(body):
	queue_free()
	if body.has_method("hit") :
		body.hit()

	
	
