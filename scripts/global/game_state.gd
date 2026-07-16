extends Node

@export var shop_scene: PackedScene = preload("res://scenes/ui/shop/shop.tscn")
@export var game_over_scene: PackedScene = preload("res://scenes/ui/game_over/game_over.tscn")

@export var base_player_damage: int = 1
@export var base_player_attack_speed: float = 1.0
@export var base_player_max_ammo: int = 50
@export var base_turret_damage: int = 1
@export var base_turret_attack_speed: float = 1.0
@export var base_turret_duration: int = 10
@export var base_turret_max_ammo: int = 10
@export var base_turret_charges: int = 3

var player_damage: int = base_player_damage
var player_attack_speed: float = base_player_attack_speed
var player_max_ammo: int = base_player_max_ammo
var player_current_ammo: int = player_max_ammo
var turret_damage: int = base_turret_damage
var turret_attack_speed: float = base_turret_attack_speed
var turret_duration: int = base_turret_duration
var turret_max_ammo: int = base_turret_max_ammo
var turret_charges: int = base_turret_charges
var wave_number: int = 1
var enemies_remaining: int = 0
var enemy_with_prize: Enemy = null
var player: Player = null
var the_prize: ThePrize = null

signal player_ammo_changed(new_ammo: int)
signal enemies_remaining_changed(new_enemies_remaining: int)
signal wave_number_changed(new_wave_number: int)
signal enemy_reached_prize()
signal clear_enemy_with_prize()
signal game_over()
signal spawn_prize_at(position: Vector2)

func _on_clear_enemy_with_prize():
    enemy_with_prize = null
    clear_enemy_with_prize.emit()

func update_enemy_with_prize(enemy: Enemy):
    if not enemy_with_prize:
        enemy_with_prize = enemy
        enemy.receive_prize()
        enemy_reached_prize.emit()
    return

func update_player_ammo(change_in_ammo: int):
    player_current_ammo = player_current_ammo + change_in_ammo
    emit_signal("player_ammo_changed", player_current_ammo)

func update_enemies_remaining(change_in_enemies: int):
    enemies_remaining = enemies_remaining + change_in_enemies
    emit_signal("enemies_remaining_changed", enemies_remaining)
    if enemies_remaining <= 0:
        Events.change_scene.emit(shop_scene)


func set_enemies_remaining(new_enemies_remaining: int):
    enemies_remaining = new_enemies_remaining
    emit_signal("enemies_remaining_changed", new_enemies_remaining)

func set_wave_time_remaining(new_wave_time_remaining: int):
    emit_signal("wave_time_remaining_changed", new_wave_time_remaining)

func increment_wave_number():
    wave_number += 1
    emit_signal("wave_number_changed", wave_number)

func _on_game_over() -> void:
    Events.change_scene.emit(game_over_scene)