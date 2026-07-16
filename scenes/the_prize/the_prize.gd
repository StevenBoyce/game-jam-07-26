extends Area2D
class_name ThePrize

func _on_area_entered(area: Area2D) -> void:
	if area.is_in_group("enemy"):
		GameState.update_enemy_with_prize(area.get_parent() as Enemy)
		queue_free()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
