@tool
class_name ChargeSpell
extends BaseSpell

var charging := false
var charge_start: float
var charge_time := 0.0


func _on_press(_source: Node2D, _direction: Vector2) -> void:
	if can_fire() and not charging:
		charging = true
		charge_start = Time.get_ticks_msec()


func _on_release(source: Node2D, direction: Vector2) -> void:
	if charging:
		charging = false
		charge_time = (Time.get_ticks_msec() - charge_start) / 1000.0
		_on_charge_release(source, direction)


func _on_charge_release(source: Node2D, direction: Vector2) -> void:
	spawn(source, direction)
