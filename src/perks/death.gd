@tool
class_name DeathPerk
extends ConstantPerk

static var name := "death"

static var title := "Death"
static var description := "Increases damage and dodge chance at 1 health"

var at_one_health := false


func _get_constant_mults() -> Dictionary:
	if not at_one_health:
		return {}
	return {
		PlayerStats.SPELL_DAMAGE: 2,
		PlayerStats.DODGE_CHANCE: 0.5,
	}


func on_damage_taken():
	at_one_health = Players.info[player].get_remaining_health() == 1


func post_init() -> void:
	Players.info[player].damage_taken.connect(on_damage_taken)
