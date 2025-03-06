@tool
class_name AntimonySpell
extends BaseSpell

const MOVE_TIME := 1.0

static var name := "antimony"

static var title := "Antimony"
static var description := "Shoots an unpredictable defense projectile"


func _on_press(source: Player, _direction: Vector2) -> void:
	if can_fire():
		await source.cast_animation(name)
		spawn(source, Util.rand_vec())


func _get_modifiers(constants: Dictionary) -> Dictionary:
	constants[DEFENSE] = true
	constants[SIZE] = 1
	constants[SPEED] = 0.5
	constants[DAMAGE] = 4
	constants[MOVEMENT] = random_move.bind([0, Vector2.ZERO, Vector2.ZERO])
	return constants


func random_move(time: float, state: Array) -> Vector2:
	var prev_start: float = state[0]
	if time - prev_start > MOVE_TIME:
		prev_start = time - fmod(time - prev_start, MOVE_TIME)
		state[0] = prev_start
		state[1] = state[2]
		state[2] = Util.rand_vec()
	var progress = (time - prev_start) / MOVE_TIME
	var prev_vec: Vector2 = state[1]
	var target_vec: Vector2 = state[2]
	return prev_vec.lerp(target_vec, progress)


func _get_cooldown() -> float:
	return 0.5
