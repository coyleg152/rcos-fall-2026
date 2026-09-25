extends Camera3D

const MOVE_SPEED = 2.0
const FLY_SPEED = 1.0
const H_LOOK_SPEED = 1.0
const V_LOOK_SPEED = 0.5
const V_LOOK_MAX = deg_to_rad(90.0)
const V_LOOK_MIN = deg_to_rad(-90.0)


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_pressed("MoveForward"):
		position.z -= cos(rotation.y) * MOVE_SPEED * delta
		position.x -= sin(rotation.y) * MOVE_SPEED * delta
	if Input.is_action_pressed("MoveBackward"):
		position.z += cos(rotation.y) * MOVE_SPEED * delta
		position.x += sin(rotation.y) * MOVE_SPEED * delta
	if Input.is_action_pressed("MoveLeft"):
		position.z += sin(rotation.y) * MOVE_SPEED * delta
		position.x -= cos(rotation.y) * MOVE_SPEED * delta
	if Input.is_action_pressed("MoveRight"):
		position.z -= sin(rotation.y) * MOVE_SPEED * delta
		position.x += cos(rotation.y) * MOVE_SPEED * delta
	if Input.is_action_pressed("FlyUp"):
		position.y += FLY_SPEED * delta
	if Input.is_action_pressed("FlyDown"):
		position.y -= FLY_SPEED * delta
	if Input.is_action_pressed("LookLeft"):
		rotation.y += H_LOOK_SPEED * delta
	if Input.is_action_pressed("LookRight"):
		rotation.y -= H_LOOK_SPEED * delta
	if Input.is_action_pressed("LookUp"):
		rotation.x = min(V_LOOK_MAX, rotation.x + V_LOOK_SPEED * delta)
	if Input.is_action_pressed("LookDown"):
		rotation.x = max(V_LOOK_MIN, rotation.x - V_LOOK_SPEED * delta)
