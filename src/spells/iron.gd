@tool
class_name IronSpell
extends ChargeSpell

static var name := "iron"

static var title := "Iron"
static var description := (
	"Charges and shoots an incresingly fast projectile, at the cost of your speed"
)


func _get_multiplicative(stat: int):
	if charging and stat == PlayerStats.MOVE_SPEED:
		return 0
	return 1


func _get_modifiers(constants: Dictionary) -> Dictionary:
	constants[SIZE] = 1
	constants[SPEED] = 2 * clampf(charge_time, 0.5, 5)
	return constants


func _get_cooldown() -> float:
	return 0.5
