class_name PlayerStats
extends Node

enum {
	HEALTH,
	DASH_COOLDOWN,
	SPELL_SLOTS,
	SPELL_COOLDOWN,
	SPELL_SIZE,
	SPELL_SPEED,
	SPELL_HOMING,
	DODGE_CHANCE,
	IFRAME_DURATION,
}

const BASE_STATS = {
	HEALTH: 4,
	DASH_COOLDOWN: 2.0,
	SPELL_SLOTS: 4,
	SPELL_COOLDOWN: 2.0,
	SPELL_SIZE: 1.0,
	SPELL_SPEED: 1.0,
	SPELL_HOMING: 0.0,
	DODGE_CHANCE: 0.0,
	IFRAME_DURATION: 0.5,
}


@export var player_id := 0;


func get_additive(_stat) -> float:
	return 0


func get_multiplicative(_stat) -> float:
	return 1


func get_stat(stat):
	return (BASE_STATS[stat] + get_additive(stat)) * get_multiplicative(stat)
