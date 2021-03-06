extends KinematicBody2D

const MAX_SPEED = 100
const ACCELERATION = 10
const FRICTION = 10
const FIX_FPS = 60

enum {
	MOVE,
}

var velocity = Vector2.ZERO
var input_vector = Vector2.ZERO
var delta_FPS  = null
var state = MOVE

func _physics_process(delta):
	delta_FPS = FIX_FPS * delta
	match state:
		MOVE:
			move_state()

func move_state():
	input_vector = Vector2.ZERO
	input_vector.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	input_vector.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	input_vector = input_vector.normalized()
	
	if input_vector != Vector2.ZERO:
		velocity = velocity.move_toward(input_vector * MAX_SPEED * delta_FPS , ACCELERATION * delta_FPS)
	else:
		velocity = velocity.move_toward(Vector2.ZERO, FRICTION * delta_FPS)
	
	velocity = move_and_slide(velocity)
