@tool
class_name ChargeSpell
extends BaseSpell

var charging := false
var charge_start: float
var charge_time := 0.0


func _on_press(source: Player, _direction: Vector2) -> void:
	if not charging and can_fire():
		charging = true
		source.cast_count += 1
		charge_start = Time.get_ticks_msec()


func _on_release(source: Player, direction: Vector2) -> void:
	if charging:
		charging = false
		source.cast_count -= 1
		charge_time = (Time.get_ticks_msec() - charge_start) / 1000.0
		_on_charge_release(source, direction)


func _on_charge_release(source: Player, direction: Vector2) -> void:
	spawn(source, direction)
