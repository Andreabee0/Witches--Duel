@tool
class_name ArsenicSpell
extends ChargeSpell

static var name := "arsenic"

static var title := "Arsenic"
static var description := "Charges and shoots a high-damange homing projectile"


func _get_modifiers(constants: Dictionary) -> Dictionary:
	constants[SIZE] = 1
	constants[DAMAGE] = clampi(int(charge_time / 2), 1, 3)
	constants[HOMING] = 2
	return constants


func _get_cooldown() -> float:
	return 0.75
