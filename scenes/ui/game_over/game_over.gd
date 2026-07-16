extends Control
class_name GameOver

@export var game_scene: PackedScene = preload("res://scenes/game/game.tscn")
@export var start_screen_scene: PackedScene = preload("res://scenes/start_screen/start_screen.tscn")


func _on_main_menu_pressed() -> void:
	Events.change_scene.emit(start_screen_scene)

func _on_quit_pressed() -> void:
	get_tree().quit()

func _on_retry_pressed() -> void:
	Events.change_scene.emit(game_scene)
