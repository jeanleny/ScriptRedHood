extends Area2D
class_name fleches
var pos: Vector2 = Vector2.ZERO

var speed: int = 500
var direction : Vector2 = Vector2.DOWN
#signal touche

func _ready():
	$Fleche.play()

func _physics_process(delta):
	position += direction * speed * delta

func _on_body_entered(body):
	queue_free()
	if body.has_method("hit"):
		body.hit()
	
	
