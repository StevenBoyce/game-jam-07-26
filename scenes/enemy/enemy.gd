extends CharacterBody2D

@export var speed: float = 50

var target: Node2D

func _physics_process(_delta: float) -> void:
	if target:
		var direction = global_position.direction_to(target.global_position)
		velocity = direction * speed
		move_and_slide()


func _on_enemy_area_area_entered(area: Area2D) -> void:
	if area.is_in_group("player_projectile"):
		area.get_parent().queue_free()
		queue_free()
	pass # Replace with function body.
