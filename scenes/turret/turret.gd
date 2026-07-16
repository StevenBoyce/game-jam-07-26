extends Node2D

var target: Node2D
@onready var projectile_scene: PackedScene = preload("res://scenes/projectile/projectile.tscn")
@onready var attack_cooldown: Timer = $AttackCooldown
@export var shooter_stats: Shooter

var can_shoot: bool = true

func _ready() -> void:
	shooter_stats.died.connect(_on_shooter_stats_died)
	attack_cooldown.wait_time = shooter_stats.current_attack_cooldown

func _on_shooter_stats_died() -> void:
	queue_free()


func _process(delta: float) -> void:
	if target:
		var direction = global_position.direction_to(target.global_position)
		rotation = direction.angle()
		if can_shoot:
			shoot()
	# else: # need enemy manager to check closest enemy to either itself or the enemy objective


func _on_area_2d_area_entered(area: Area2D) -> void:
	if not target:
		if area.is_in_group("enemy"):
			target = area
			# shoot()


func _on_attack_cooldown_timeout() -> void:
	can_shoot = true
	# shoot()


func shoot():
	if can_shoot:
		var projectile = projectile_scene.instantiate()
		projectile.direction = global_position.direction_to(target.global_position)
		projectile.spawn_position = global_position
		projectile.spawn_rotation = global_position.direction_to(target.global_position).angle()
		get_tree().root.add_child(projectile)
		can_shoot = false
		attack_cooldown.start()