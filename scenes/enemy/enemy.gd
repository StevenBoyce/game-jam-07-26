extends CharacterBody2D
class_name Enemy

var world_boundary: WorldBoundary

@export var speed: float = 50

var is_dead := false

var target: Node2D
var prize_acquired: bool = false
var i_have_prize: bool = false
var escape_direction: Vector2 = Vector2.ZERO

func _ready():
	GameState.enemy_reached_prize.connect(on_prize_acquired)
	GameState.clear_enemy_with_prize.connect(clear_enemy_with_prize)

func clear_enemy_with_prize():
	prize_acquired = false
	i_have_prize = false
	target = null

func _physics_process(_delta: float) -> void:
	if i_have_prize:
		velocity = escape_direction * speed
		move_and_slide()
		return
	if target:
		var direction = global_position.direction_to(target.global_position)
		velocity = direction * speed
		move_and_slide()
	else:
		if GameState.the_prize:
			target = GameState.the_prize

func die(area_responsible: Area2D):
	if is_dead:
		return
	if i_have_prize:
		GameState.spawn_prize_at.emit(global_position)
		GameState._on_clear_enemy_with_prize()

	is_dead = true
	set_deferred("collision_layer", 0)
	set_deferred("collision_mask", 0)
	GameState.update_enemies_remaining(-1)
	area_responsible.get_parent().queue_free()
	queue_free()

func _on_enemy_area_area_entered(area: Area2D) -> void:
	if area.is_in_group("player_projectile"):
		die(area)
	pass # Replace with function body.

func on_prize_acquired():
	prize_acquired = true
	target = GameState.player

func receive_prize():
	i_have_prize = true
	escape_direction = world_boundary.get_escape_direction(global_position)
	set_deferred("collision_layer", 5)
	set_deferred("collision_mask", 5)