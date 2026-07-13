extends Control
class_name Shop

@export var game_scene: PackedScene = preload("res://scenes/game/game.tscn")

@onready var next_wave_button: Button = %NextWaveButton

func _ready() -> void:
	next_wave_button.pressed.connect(on_next_wave_button_pressed)

func on_next_wave_button_pressed() -> void:
	GameState.increment_wave_number()
	Events.change_scene.emit(game_scene)
