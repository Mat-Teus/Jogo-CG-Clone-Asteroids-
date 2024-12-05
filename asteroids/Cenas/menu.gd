class_name MainMenu
extends Control

@onready var start_button = $MarginContainer2/HBoxContainer/VBoxContainer/Jogar
@onready var exit_button = $MarginContainer2/HBoxContainer/VBoxContainer/Sair
@onready var level = preload("res://world.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	start_button.button_down.connect(on_start_pressed)
	exit_button.button_down.connect(on_exit_pressed)

func on_exit_pressed() -> void:
	get_tree().quit()

func on_start_pressed() -> void:
	get_tree().change_scene_to_packed(level)
