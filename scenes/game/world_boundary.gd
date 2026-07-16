extends Area2D
class_name WorldBoundary

## Returns a unit direction toward the closest edge of the rectangle from `from`.
func get_escape_direction(from: Vector2) -> Vector2:
	var shape_node := $CollisionShape2D as CollisionShape2D
	var rect_shape := shape_node.shape as RectangleShape2D
	var half := rect_shape.size * 0.5
	var center := shape_node.global_position

	var left := center.x - half.x
	var right := center.x + half.x
	var top := center.y - half.y
	var bottom := center.y + half.y

	var d_left := from.x - left
	var d_right := right - from.x
	var d_top := from.y - top
	var d_bottom := bottom - from.y

	if d_left <= d_right and d_left <= d_top and d_left <= d_bottom:
		return Vector2.LEFT
	if d_right <= d_top and d_right <= d_bottom:
		return Vector2.RIGHT
	if d_top <= d_bottom:
		return Vector2.UP
	return Vector2.DOWN
