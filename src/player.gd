@tool
class_name Player
extends CharacterBody2D

# spells to use in testing
var testing_spells := []

var cast_count := 0
var is_casting := false
var is_moving := false
var selections: Selections


func update_color() -> void:
	var color: PlayerColor = Players.get_color_for_joined(selections.device)
	$Robe.modulate = color.primary
	$Belt.modulate = color.secondary
	$Cursor.modulate = color.primary


func cast_animation(spell: String, length := 0.25) -> void:
	cast_count += 1
	$Spell.texture = SpellRegistry.get_spell_texture(spell)
	await get_tree().create_timer(length).timeout
	cast_count -= 1


func _ready() -> void:
	if Engine.is_editor_hint():
		return
	if not selections:
		print("adding keyboard player with spells: ", testing_spells)
		# create keyboard device with testing spells
		selections = Selections.new(DeviceInput.new(-1))
		for i in testing_spells.size():
			selections.set_spell(i, SpellRegistry.new_spell_instance(testing_spells[i]))
		Players.selections[-1] = selections
		Players.colors[-1] = PlayerColor.colors[0]
	update_color()


func _process(_delta: float) -> void:
	if Engine.is_editor_hint():
		return
	var pressed := selections.buttons_pressed(true)
	is_casting = not pressed.is_empty()
	for button in pressed:
		var spell: BaseSpell = selections.spells[button]
		spell._on_press(self, Vector2.from_angle($Cursor.rotation))
	var released := selections.buttons_has_pressed(true)
	for button in released:
		var spell: BaseSpell = selections.spells[button]
		spell._on_release(self, Vector2.from_angle($Cursor.rotation))


func _physics_process(_delta: float) -> void:
	if Engine.is_editor_hint():
		return
	var direction := get_movement_vector()
	if !direction.is_zero_approx():
		velocity = direction * selections.get_stat(PlayerStats.MOVE_SPEED) * 800
		is_moving = true
		if direction.x > 0:
			flip_right()
		if direction.x < 0:
			flip_left()
	else:
		velocity = Vector2(0, 0)
		is_moving = false
	$Cursor.update_look(selections.device)
	move_and_slide()


func get_movement_vector() -> Vector2:
	return selections.device.get_vector("move_left", "move_right", "move_up", "move_down")


func flip_left() -> void:
	$Base.flip_h = false
	$Robe.flip_h = false
	$Belt.flip_h = false


func flip_right() -> void:
	$Base.flip_h = true
	$Robe.flip_h = true
	$Belt.flip_h = true


func _on_collider_area_entered(area: Area2D) -> void:
	if area.is_in_group("bullet"):
		if area.get_parent().source != selections.device.device:
			print("hit")


func _get_property_list() -> Array[Dictionary]:
	var hint_string := (
		"%d/%d:%s" % [TYPE_STRING, PROPERTY_HINT_ENUM, ",".join(SpellRegistry.all_spells.keys())]
	)

	return [
		{
			"name": "testing_spells",
			"type": TYPE_ARRAY,
			"hint": PROPERTY_HINT_TYPE_STRING,
			"hint_string": hint_string
		}
	]


func _property_can_revert(property: StringName) -> bool:
	if property == "testing_spells":
		return true
	return false


func _property_get_revert(property: StringName) -> Variant:
	if property == "testing_spells":
		return []
	return null
