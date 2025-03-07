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


func is_defense() -> bool:
	return true
