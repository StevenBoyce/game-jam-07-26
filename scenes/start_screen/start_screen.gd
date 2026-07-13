extends Control
class_name StartScreen

@export var game_scene: PackedScene = preload("res://scenes/game/game.tscn")

func _ready() -> void:
	pass

func _on_start_button_pressed() -> void:
	Events.change_scene.emit(game_scene)


func _on_quit_button_pressed() -> void:
	get_tree().quit()
