@tool
class_name DefenseBullet
extends Bullet

const DEFENSE_SIZE_TEXTURES := [
	preload("res://sprites/defense_small.png"),
	preload("res://sprites/defense_med.png"),
	preload("res://sprites/defense_large.png"),
	preload("res://sprites/defense_huge.png"),
]

const DEFENSE_SIZE_RADII = [49, 77, 105, 133]


func set_size(value: int):
	size = clamp(value, 0, DEFENSE_SIZE_TEXTURES.size() - 1)
	$Shape.shape.size.x = DEFENSE_SIZE_RADII[size]
	$Shape.shape.size.y = DEFENSE_SIZE_RADII[size]
	$Sprite.texture = DEFENSE_SIZE_TEXTURES[size]


func handle_homing(delta: float) -> void:
	var closest_pos := Vector2.INF
	for node in get_tree().get_nodes_in_group("bullets"):
		if not node is Bullet:
			continue
		var bullet: Bullet = node
		var distance_vector := bullet.global_position - global_position
		if not closest_pos.is_finite() or distance_vector.length() < closest_pos.length():
			closest_pos = distance_vector
	if closest_pos.is_finite():
		home_towards(closest_pos, delta)


func is_defense() -> bool:
	return true
