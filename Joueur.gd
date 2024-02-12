extends CharacterBody2D
var pos: Vector2 = Vector2.ZERO
var  vitesse = 200
const vitesse_saut = -600
var start : Vector2 = Vector2(13,611)
var buffered_jump : bool = false
var idle_state : bool = true
var invincible : bool = false

signal ending

@export var jump_height : float
@export var jump_time_to_peak : float
@export var jump_time_to_descent : float

@onready var jump_velocity : float = ((2.0 * jump_height) / jump_time_to_peak) * -1.0
@onready var jump_gravity : float = ((-2.0 * jump_height) / (jump_time_to_peak * jump_time_to_peak)) * - 1.0
@onready var fall_gravity : float = ((-2.0 * jump_height) / (jump_time_to_descent * jump_time_to_descent)) * -1.0

@onready var coyote_time = $Coyote_time
@onready var buffer_time = $BufferTimer

func _ready():
	pos = Vector2(13,611)
	position = pos

func _physics_process(delta):
	if position.y > 710 :
		get_tree().change_scene_to_file("res://Menu/game_over.tscn")
		Global.health = 3

	var was_on_floor = is_on_floor()
	move_and_slide()
	var just_left = was_on_floor and not is_on_floor() and velocity.y >= 0
	if just_left : 
		coyote_time.start()

	if not is_on_floor():
		velocity.y += get_gravity() * delta

	if is_on_floor() or coyote_time.time_left > 0.0 :
		if Input.is_action_just_pressed("Saut") or buffered_jump == true  :
			velocity.y = jump_velocity
			buffered_jump = false
			
	if Input.is_action_just_pressed("Saut"):
		buffered_jump = true
		buffer_time.start()
		
	if velocity.y < 0 :
		saut()
	if velocity.y > 0 :
		chute()

	var direction = Input.get_axis("Gauche","Droite")
	if direction :
		velocity.x = direction * vitesse
		slow_friction(delta)
		if Input.is_action_pressed("Droite"):
			marche()
		else :
			marche_gauche()

	else :
		velocity.x = move_toward(velocity.x,0,vitesse)
		idle()

func hit():
	if Global.health > 0 and invincible == false:
		intouchable()
		idle_state = false
		Global.health -= 1
		$AnimationPlayer.play("Touché")
		await $AnimationPlayer.animation_finished
		idle_state = true
	if Global.health == 0:
		get_tree().change_scene_to_file("res://Menu/game_over.tscn")
		Global.health = 3

func slow_friction(d):
		velocity.x -= .02 * d
	
func get_gravity() -> float :
	return jump_gravity if velocity.y < 0.0 else fall_gravity

func _on_buffer_timer_timeout():
	buffered_jump = false

func marche_gauche():
	if is_on_floor() and idle_state:
		$AnimationPlayer.play("Marche_Gauche")
	
func marche():
	if is_on_floor() and idle_state:
		$AnimationPlayer.play("Marche")
	
func idle():
	if is_on_floor() and idle_state :
		$AnimationPlayer.play("Idle")
	
func saut():
	if idle_state:
		$AnimationPlayer.play("Saut")
	
func chute():
	if idle_state :
		$AnimationPlayer.play("Chute")

func _on_house_zoom_cam():
	if Global.got_key :
		var tween = get_tree().create_tween()
		tween.tween_property($Camera2D, "zoom",Vector2 (3.5 , 3.5), 5)
		print("fin")
		ending.emit()

func intouchable():
	invincible = true
	$InvincibleTimer.start()

func _on_invincible_timer_timeout():
	print("cbon")
	invincible = false
