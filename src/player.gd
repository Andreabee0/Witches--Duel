@tool
class_name Player
extends CharacterBody2D

const CAST_SOUND: AudioStream = preload("res://sounds/cast.wav")
const HIT_SOUND: AudioStream = preload("res://sounds/hit.wav")
const DIE_SOUND: AudioStream = preload("res://sounds/die.wav")

const BASE_HITBOX := [44.0, 112.0]
const DASH_TIME := 0.1
const DASH_DIST := 300

var testing_spells := []

var cast_count := 0
var is_casting := false
var is_moving := false
var is_dead := false

var dash_progress := -1.0
var dash_direction: Vector2
var info: PlayerInfo


func update_color() -> void:
	var color: PlayerColor = Players.get_color_for_joined(info.device)
	$Robe.modulate = color.primary
	$Belt.modulate = color.secondary
	$Cursor.modulate = color.primary


func cast_animation(spell: String, length := 0.25) -> void:
	cast_count += 1
	$Spell.texture = SpellRegistry.get_spell_texture(spell)
	await get_tree().create_timer(length).timeout
	cast_count -= 1
	play_cast()


func play_cast() -> void:
	SoundPlayer.play_sound(CAST_SOUND, -5)


func _ready() -> void:
	if Engine.is_editor_hint():
		return
	if not info:
		print("adding test player")
		info = PlayerInfo.new(DeviceInput.new(-1))
		Players.info[-1] = info
		Players.colors[-1] = PlayerColor.colors[0]
		if GlobalInfo.current_arena_bounds.get_area() == 0:
			GlobalInfo.current_arena_bounds = get_viewport_rect()
	if info.spells.is_empty():
		print("adding test spells: ", testing_spells)
		for i in testing_spells.size():
			info.set_spell(i, SpellRegistry.new_spell_instance(testing_spells[i]))
	update_color()


func _process(delta: float) -> void:
	if Engine.is_editor_hint() or is_dead:
		return
	if info.get_remaining_health() <= 0:
		SoundPlayer.play_sound(DIE_SOUND, 1)
		$Hitbox.monitoring = false
		is_dead = true
		return
	var pressed := info.buttons_pressed(true)
	is_casting = not pressed.is_empty()
	for button in pressed:
		var spell: BaseSpell = info.spells[button]
		spell._on_press(self, Vector2.from_angle($Cursor.rotation))
	var released := info.buttons_has_pressed(true)
	for button in released:
		var spell: BaseSpell = info.spells[button]
		spell._on_release(self, Vector2.from_angle($Cursor.rotation))
	set_hitbox_size(info.get_stat(PlayerStats.HITBOX))
	info.update_perk(delta)


func _physics_process(delta: float) -> void:
	if Engine.is_editor_hint() or is_dead:
		return
	var direction := get_movement_vector()
	if !direction.is_zero_approx():
		velocity = direction * info.get_stat(PlayerStats.MOVE_SPEED) * 800
		is_moving = true
		if direction.x > 0:
			flip_right()
		if direction.x < 0:
			flip_left()
	else:
		velocity = Vector2(0, 0)
		is_moving = false
	if dash_progress >= 0:
		dash_progress += delta
		velocity += dash_direction * DASH_DIST / DASH_TIME
	if dash_progress > DASH_TIME:
		end_dash()
	$Cursor.update_look(info.device)
	move_and_slide()
	if is_moving and info.should_dash():
		start_dash(direction.normalized())


func get_movement_vector() -> Vector2:
	return info.device.get_vector("move_left", "move_right", "move_up", "move_down")


func start_dash(direction: Vector2) -> void:
	dash_progress = 0
	dash_direction = direction
	$Base.modulate.a = 0.1
	$Robe.modulate.a = 0.1
	$Belt.modulate.a = 0.1


func end_dash() -> void:
	dash_progress = -1
	await get_tree().create_timer(0.1).timeout
	$Base.modulate.a = 1
	$Robe.modulate.a = 1
	$Belt.modulate.a = 1


func flip_left() -> void:
	$Base.flip_h = false
	$Robe.flip_h = false
	$Belt.flip_h = false


func flip_right() -> void:
	$Base.flip_h = true
	$Robe.flip_h = true
	$Belt.flip_h = true


func set_hitbox_size(mult: float):
	var shape: CapsuleShape2D = $Hitbox/Collider.shape
	shape.radius = BASE_HITBOX[0] * mult
	shape.height = BASE_HITBOX[1] * mult


func _on_hitbox_entered(body: Node2D) -> void:
	if body.is_in_group("bullets") and body is Bullet:
		var bullet: Bullet = body
		if not bullet.source != info.device.device or dash_progress >= 0:
			return
		if info.handle_hit(bullet.damage):
			SoundPlayer.play_sound(HIT_SOUND, 1)
			bullet.queue_free()


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
