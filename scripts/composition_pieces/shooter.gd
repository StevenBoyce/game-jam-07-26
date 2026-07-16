extends Stats
class_name Shooter

@export var base_attack_cooldown: float = 1.0
@export var base_max_ammo: int = 10

var current_attack_cooldown: float = base_attack_cooldown
var current_max_ammo: int = base_max_ammo
var current_ammo: int = base_max_ammo

func _init():
    super._init()

func setup_stats():
    super.setup_stats()
    current_attack_cooldown = base_attack_cooldown
    current_max_ammo = base_max_ammo
    current_ammo = base_max_ammo