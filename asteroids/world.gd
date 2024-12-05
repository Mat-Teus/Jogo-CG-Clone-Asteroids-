extends Node3D

var game_over = preload("res://Cenas/game_over.tscn")
@onready var explosion_audio = $MobDying

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_colisao_body_entered(body):
	if body.name == "Mob":
		get_tree().change_scene_to_packed(game_over)
	if body.name == "Mob2":
		get_tree().change_scene_to_packed(game_over)
	if body.name == "Mob3":
		get_tree().change_scene_to_packed(game_over)
	if body.name == "Mob4":
		get_tree().change_scene_to_packed(game_over)


func _on_area_3d_body_entered(body):
	if body.name == "Mob":
		$Mob.position = Vector3(-12.78954, 2.63712, -10.4413)
	if body.name == "Mob2":
		$Mob2.position = Vector3(-4.83528, 2.63712, -12.7733)
	if body.name == "Mob3":
		$Mob3.position = Vector3(10.2339, 2.63712, -12.0924)
	if body.name == "Mob4":
		$Mob4.position = Vector3(2.79065, 2.63712, -15.5446)


func _on_player_mob():
	if $Player.collider == $Mob.get_rid():
		explosion_audio.play()
		$Mob.position = Vector3(-12.78954, 2.63712, -10.4413)
	if $Player.collider == $Mob2.get_rid():
		explosion_audio.play()
		$Mob2.position = Vector3(-4.83528, 2.63712, -12.7733)
	if  $Player.collider == $Mob3.get_rid():
		explosion_audio.play()
		$Mob3.position = Vector3(10.2339, 2.63712, -12.0924)
	if  $Player.collider == $Mob4.get_rid():
		explosion_audio.play()
		$Mob4.position = Vector3(2.79065, 2.63712, -15.5446)
