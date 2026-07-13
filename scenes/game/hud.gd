extends Control
class_name Hud

@onready var ammo_value: Label = %AmmoValue
@onready var wave_number: Label = %WaveValue
@onready var enemies_remaining: Label = %EnemiesValue

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	ammo_value.text = str(GameState.player_current_ammo)
	wave_number.text = str(GameState.wave_number)
	GameState.player_ammo_changed.connect(on_player_ammo_changed)
	GameState.enemies_remaining_changed.connect(on_enemies_remaining_changed)

func on_player_ammo_changed(new_ammo: int):
	ammo_value.text = str(new_ammo)

func on_enemies_remaining_changed(new_enemies_remaining: int):
	enemies_remaining.text = str(new_enemies_remaining)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
