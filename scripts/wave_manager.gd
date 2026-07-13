extends Node

@export var base_enemy_amount: int = 10
@export var wave_number: int = 1
@export var wave_duration: int = 10
@export var wave_enemy_scaling: float = 1.2
@export var wave_duration_scaling: float = 1.2

var current_wave_duration: int = wave_duration
var current_enemy_amount: int = base_enemy_amount


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Events.wave_start_clicked.connect(on_wave_start_clicked)
	GameState.wave_ended.connect(on_wave_ended)
	GameState.set_wave_number(wave_number)
	GameState.wave_number_changed.connect(on_wave_start_clicked)

func on_wave_ended() -> void:
	print("wave ended")

func on_wave_start_clicked() -> void:
	wave_number = GameState.wave_number
	current_wave_duration = wave_duration * wave_duration_scaling * wave_number
	current_enemy_amount = base_enemy_amount * wave_enemy_scaling * wave_number
	print(current_enemy_amount)
	GameState.set_enemies_remaining(current_enemy_amount)
	GameState.set_wave_time_remaining(current_wave_duration)
	Events.wave_started.emit()
