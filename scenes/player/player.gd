extends CharacterBody2D

@onready var animated_sprite: AnimatedSprite2D = %AnimatedSprite
var projectile_scene: PackedScene = preload("res://scenes/projectile/projectile.tscn")
@onready var spawn_position: Node2D = %BulletExitPosition
var direction: Vector2
@onready var turret_scene: PackedScene = preload("res://scenes/turret/turret.tscn")
@export var movement_speed: float = 300.0


func _physics_process(_delta: float) -> void:
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	direction.x = Input.get_axis("move_left", "move_right")
	direction.y = Input.get_axis("move_up", "move_down")
	direction = direction.normalized()

	if direction.x > 0:
		animated_sprite.flip_h = false
	elif direction.x < 0:
		animated_sprite.flip_h = true
	if direction:
		velocity = direction * movement_speed
		if animated_sprite.animation != "walk":
			animated_sprite.animation = "walk"
	else:
		velocity = Vector2.ZERO
		if animated_sprite.animation != "idle":
			animated_sprite.animation = "idle"
	move_and_slide()


func _input(event: InputEvent) -> void:
	if event.is_action_pressed("shoot"):
		if GameState.player_current_ammo > 0:
			var mouse_position = get_global_mouse_position()
			var projectile = projectile_scene.instantiate()
			projectile.direction = global_position.direction_to(mouse_position)
			projectile.spawn_position = spawn_position.global_position
			projectile.spawn_rotation = global_position.direction_to(mouse_position).angle()
			get_tree().root.add_child(projectile)
			GameState.update_player_ammo(-1)
	if event.is_action_pressed("secondary_action"):
		spawn_turret()


func spawn_turret():
	var turret = turret_scene.instantiate()
	turret.position = global_position
	get_parent().add_child(turret)