extends Node


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

# we probably care about wave number and whatnot too
func spawn_enemies(arena: CollisionShape2D):
	var extents = arena.size/2
	var edge = randi_range(0, 3) # 0 = top, 1 = right, 2 = bottom, 3 = left
	var position = Vector2.ZERO
	match edge:
		0:
			position.x = randi_range(-extents.x, extents.x)
			position.y = -extents.y
		1:
			position.x = extents.x
			position.y = randi_range(-extents.y, extents.y)
		2:
			position.x = randi_range(-extents.x, extents.x)
			position.y = extents.y
		3:
			position.x = -extents.x
			position.y = randi_range(-extents.y, extents.y)
	print(position)
		# var enemy = Enemy.instantiate()
		# enemy.position = position
		# add_child(enemy)