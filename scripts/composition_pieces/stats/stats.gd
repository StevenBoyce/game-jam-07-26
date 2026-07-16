extends Resource
class_name Stats
@export var base_max_health: int = 100
@export var base_speed: float = 100
@export var base_damage: int = 10
@export var base_defense: int = 0

var current_health: int = base_max_health
var current_speed: float = base_speed
var current_damage: int = base_damage
var current_defense: int = base_defense

signal died()

func _init():
	setup_stats.call_deferred()

# not sure why, but the default values override exported values unless you do this
func setup_stats():
	current_health = base_max_health
	current_speed = base_speed
	current_damage = base_damage
	current_defense = base_defense

func take_damage(amount: int):
	current_health -= amount
	if current_health <= 0:
		current_health = 0
		died.emit()
