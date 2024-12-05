extends CharacterBody3D


const SPEED = 0.005
const JUMP_VELOCITY = 4.5


func _physics_process(delta: float) -> void:
	#velocity.z += SPEED
	move_and_slide()
