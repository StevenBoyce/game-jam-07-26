extends Node2D

@onready var enemy_scene: PackedScene = preload("res://scenes/enemy/enemy.tscn")
@onready var enemy_objective: Sprite2D = $EnemyObjective
@onready var SpawnerTop: Marker2D = $SpawnerTop
@onready var SpawnerBottom: Marker2D = $SpawnerBottom
@onready var SpawnerLeft: Marker2D = $SpawnerLeft
@onready var SpawnerRight: Marker2D = $SpawnerRight

const WaveManager = preload("res://scripts/wave_manager.gd")
const SPAWN_COOLDOWN := 0.5

var wave_manager: WaveManager
var enemies_left_to_spawn: int = 0
var spawn_points: Array[Marker2D] = []
var spawn_point_timers: Array[Timer] = []


func _ready() -> void:
	wave_manager = WaveManager.new()
	spawn_points = [SpawnerTop, SpawnerBottom, SpawnerLeft, SpawnerRight]
	_setup_spawn_point_timers()
	Events.wave_started.connect(on_wave_started)
	wave_manager.on_wave_start_clicked()


func _setup_spawn_point_timers() -> void:
	for point in spawn_points:
		var timer := Timer.new()
		timer.wait_time = SPAWN_COOLDOWN
		timer.one_shot = false
		timer.timeout.connect(_on_spawn_point_timeout.bind(point))
		point.add_child(timer)
		spawn_point_timers.append(timer)


func on_wave_started() -> void:
	enemies_left_to_spawn = int(wave_manager.current_enemy_amount)
	for timer in spawn_point_timers:
		timer.start()


func _on_spawn_point_timeout(spawn_point: Marker2D) -> void:
	if enemies_left_to_spawn <= 0:
		_stop_spawn_timers()
		return

	_spawn_enemy_at(spawn_point)
	enemies_left_to_spawn -= 1

	if enemies_left_to_spawn <= 0:
		_stop_spawn_timers()


func _spawn_enemy_at(spawn_point: Marker2D) -> void:
	var enemy = enemy_scene.instantiate()
	enemy.target = enemy_objective
	enemy.position = spawn_point.global_position
	add_child(enemy)


func _stop_spawn_timers() -> void:
	for timer in spawn_point_timers:
		timer.stop()
