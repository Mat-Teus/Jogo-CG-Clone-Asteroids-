extends CharacterBody3D

const SPEED = 5.0
const JUMP_VELOCITY = 4.5

var _mouse_input : bool = false
var _mouse_rotation : Vector3
var _rotation_input : float
var _tilt_input : float
var collider

@onready var shot_audio = $Shot
@export var TILT_LOWER_LIMIT := deg_to_rad(-90.0)
@export var TILT_UPPER_LIMIT := deg_to_rad(90.0)
var CAMERA_CONTROLLER : Camera3D

signal mob
signal mob2
signal mob3
signal mob4

func _unhandled_input(event):
	_mouse_input = event is InputEventMouseMotion and Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED
	if _mouse_input:
		_rotation_input = -event.relative.x
		_tilt_input = -event.relative.y

func _ready():
	if CAMERA_CONTROLLER == null:
		CAMERA_CONTROLLER = $Node3D/Camera3D
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	_mouse_rotation = Vector3.ZERO  # Inicializa a rotação da câmera


func _physics_process(delta: float) -> void:
	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY
	
	if Input.is_action_just_pressed("attack"):
		shot_audio.play()
		_attack()
	# Get the input direction and handle the movement/deceleration.
	var input_dir := Input.get_vector("mover_esquerda", "mover_direita", "mover_frente", "mover_trás")
	var direction := (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)

	move_and_slide()
	_update_camera(delta)

# Método para atualizar a rotação da câmera
func _update_camera(delta: float) -> void:
	# Atualizar rotação horizontal (em torno do eixo Y do personagem)
	_rotation_input *= delta * 0.1  # Sensibilidade ajustável
	_mouse_rotation.y += _rotation_input
	
	# Atualizar a rotação vertical (inclinação da câmera)
	_tilt_input *= delta * 0.1  # Sensibilidade ajustável
	_mouse_rotation.x = clamp(_mouse_rotation.x + _tilt_input, TILT_LOWER_LIMIT, TILT_UPPER_LIMIT)

	# Aplicar rotação ao personagem e à câmera
	# Rotacionar o corpo do personagem horizontalmente (eixo Y)
	rotation.y = _mouse_rotation.y
	
	# Rotacionar a câmera verticalmente (eixo X)
	CAMERA_CONTROLLER.rotation_degrees.x = _mouse_rotation.x

func _attack():
	var camera = CAMERA_CONTROLLER
	var space_state = camera.get_world_3d().direct_space_state
	var screen_center = get_viewport().size / 2
	var origin = camera.project_ray_origin(screen_center)
	var end = origin + camera.project_ray_normal(screen_center) * 1000
	var query = PhysicsRayQueryParameters3D.create(origin,end)
	query.collide_with_bodies = true
	var result = space_state.intersect_ray(query)
	print(result)
	collider = result.get("rid")
	print(collider)
	if result:
		mob.emit()
