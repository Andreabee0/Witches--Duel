class_name PlayerStats
extends Node

enum {
	HEALTH,
	DASH_COOLDOWN,
	SPELL_SLOTS,
	SPELL_COOLDOWN,
	SPELL_SIZE,
	SPELL_SPEED,
	SPELL_DAMAGE,
	SPELL_HOMING,
	DODGE_CHANCE,
	DAMAGE_TAKEN,
	IFRAME_DURATION,
	MOVE_SPEED,
}

const BASE_STATS = {
	HEALTH: 4,
	DASH_COOLDOWN: 1.0,
	SPELL_SLOTS: 4,
	SPELL_COOLDOWN: 1.0,
	SPELL_SIZE: 1.0,
	SPELL_SPEED: 1.0,
	SPELL_DAMAGE: 1.0,
	SPELL_HOMING: 0.0,
	DODGE_CHANCE: 0.0,
	DAMAGE_TAKEN: 1.0,
	IFRAME_DURATION: 1.0,
	MOVE_SPEED: 1.0,
}

var player_id := 0
# button to spell
var spells := {}
var perk: BasePerk


func get_additive(stat) -> float:
	var ret = perk._get_additive(stat) if perk != null else 0.0
	for spell in spells:
		if spell != null:
			ret += spell._get_additive(stat)
	return ret


func get_multiplicative(stat) -> float:
	var ret = perk._get_multiplicative(stat) if perk != null else 1.0
	for spell in spells:
		if spell != null:
			ret *= spell._get_multiplicative(stat)
	return ret


func get_stat(stat) -> float:
	return (BASE_STATS[stat] + get_additive(stat)) * get_multiplicative(stat)
