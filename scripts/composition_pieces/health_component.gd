extends Node
class_name HealthComponent

@export var max_health: int = 100
@export var current_health: int = max_health


func take_damage(amount: int) -> void:
	current_health -= amount
	if current_health <= 0:
		die()

func die() -> void:
	pass

func heal(amount: int) -> void:
	current_health += amount
	if current_health > max_health:
		current_health = max_health
