extends Camera3D

const MOVE_SPEED = 2.0
const FLY_SPEED = 1.5
const H_LOOK_SPEED = 1.0
const V_LOOK_SPEED = 0.5
const V_LOOK_MAX = deg_to_rad(90.0)
const V_LOOK_MIN = deg_to_rad(-90.0)
const ORBIT_SPEED = deg_to_rad(15.0)
const TWO_PI = deg_to_rad(360.0)
const MIN_ORBIT_RADIUS = 1.0
const MAX_ORBIT_RADIUS = 20.0
const ORBIT_HEIGHT = 5.0
const ORBIT_TILT = deg_to_rad(-10.0)

enum {
	MODE_FREE_FLY = 0,
	MODE_ORBIT = 1,
}

var camera_mode = MODE_FREE_FLY
var orbit_angle = 0.0
var orbit_radius = 10.0


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float):
	if Input.is_action_just_pressed("ToggleFlightMode"):
		match camera_mode:
			MODE_FREE_FLY:
				camera_mode = MODE_ORBIT
			MODE_ORBIT:
				camera_mode = MODE_FREE_FLY

	match camera_mode:
		MODE_FREE_FLY:
			camera_free_fly(delta)
		MODE_ORBIT:
			camera_orbit(delta)


func camera_free_fly(delta: float):
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


func camera_orbit(delta: float):
	if Input.is_action_pressed("MoveForward"):
		orbit_radius = max(MIN_ORBIT_RADIUS, orbit_radius - MOVE_SPEED * delta)
	if Input.is_action_pressed("MoveBackward"):
		orbit_radius = min(MAX_ORBIT_RADIUS, orbit_radius + MOVE_SPEED * delta)
	
	position.y = ORBIT_HEIGHT
	rotation.x = ORBIT_TILT
	rotation.y = orbit_angle
	position.x = orbit_radius * sin(orbit_angle)
	position.z = orbit_radius * cos(orbit_angle)

	orbit_angle += ORBIT_SPEED * delta
	if orbit_angle >= TWO_PI:
		orbit_angle -= TWO_PI
