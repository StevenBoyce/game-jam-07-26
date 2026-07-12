extends Node2D

@onready var enemy_scene: PackedScene = preload("res://scenes/enemy/enemy.tscn")
@onready var enemy_objective: Sprite2D = $EnemyObjective
@onready var SpawnerTop: Marker2D = $SpawnerTop
@onready var SpawnerBottom: Marker2D = $SpawnerBottom
@onready var SpawnerLeft: Marker2D = $SpawnerLeft
@onready var SpawnerRight: Marker2D = $SpawnerRight


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

# we probably care about wave number and whatnot too
func spawn_enemies():
	var point = get_random_spawn_point()
	var enemy = enemy_scene.instantiate()
	enemy.target = enemy_objective
	enemy.position = point.global_position
	add_child(enemy)

func _on_enemy_spawn_timer_timeout() -> void:
	spawn_enemies()


func get_random_spawn_point() -> Marker2D:
	var spawn_points = [SpawnerTop, SpawnerBottom, SpawnerLeft, SpawnerRight]
	return spawn_points.pick_random()
