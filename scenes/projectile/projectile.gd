extends CharacterBody2D
class_name Projectile

@export var speed = 300

var direction: Vector2
var spawn_position: Vector2
var spawn_rotation : float

func _ready():
	global_position = spawn_position
	global_rotation = spawn_rotation

func _physics_process(_delta: float):
	velocity = direction * speed
	move_and_slide()

func _on_despawn_timer_timeout() -> void:
	queue_free()
