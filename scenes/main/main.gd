extends Node2D
class_name Main

@export var start_scene: PackedScene = preload("res://scenes/start_screen/start_screen.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Events.change_scene.connect(on_change_scene)
	var start_screen = start_scene.instantiate()
	add_child(start_screen)

func on_change_scene(scene: PackedScene) -> void:
	for child in get_children():
		child.queue_free()
	var new_scene = scene.instantiate()
	add_child(new_scene)
