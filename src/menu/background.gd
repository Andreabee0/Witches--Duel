extends Control

const MARGIN := 100
const MARGIN_SUBTRACT := Vector2.ONE * MARGIN

static var textures: Array[Texture2D] = []

@export var spacing := 75.0
@export var speed := 100.0
@export var pos_variance := 0.0
@export var move_speed_variance := 0.0
@export var rot_variance := 0.0
@export var rot_speed_variance := 0.0

var angle := 0.0
var forward := Vector2.RIGHT
var left := Vector2.UP
var time := 0.0
var corner_offset := 0.0

var neg_lines := []
var pos_lines := []


static func _static_init() -> void:
	const BASE := "res://sprites/symbols/"
	for file_name in DirAccess.get_files_at(BASE):
		if file_name.ends_with(".import"):
			var image_name := BASE + file_name.replace(".import", "")
			textures.append(load(image_name))
			print("loaded ", image_name)


func create_sprite(pos: Vector2, rot: float) -> Sprite2D:
	var copy: Sprite2D = $TemplateSprite.duplicate()
	copy.texture = textures[randi_range(0, textures.size() - 1)]
	copy.position = pos
	copy.rotation = rot
	add_child(copy)
	return copy


func remove_sprite(sprite: Sprite2D):
	sprite.queue_free()


func randf_sym(min_max: float) -> float:
	return randf_range(-min_max, min_max)


func new_pos_offset() -> Vector2:
	return Vector2.from_angle(randf_range(0, PI * 2)) * randf_range(0, pos_variance * spacing / 3)


func new_line() -> Array:
	return [[], randf_range(0, spacing / 4), randf_sym(move_speed_variance) + 1]


func calc_min_offset(rect_size: Vector2) -> float:
	return -rect_size.y * cos(angle)


func calc_max_offset(rect_size: Vector2) -> float:
	return rect_size.x * cos(PI / 2 - angle)


func calc_line_start(offset: float) -> float:
	if offset < 0:
		return -offset * tan(angle)
	if offset > 0:
		return offset * tan(PI / 2 - angle)
	return 0


func calc_line_length(rect_size: Vector2, offset: float) -> float:
	var cos_angle := 1 / cos(angle)
	var cos_angle_inv := 1 / cos(PI / 2 - angle)
	var w_off := offset * cos_angle_inv
	var h_off := -offset * cos_angle
	var right_hit_length := (rect_size.x - w_off) * cos_angle
	var bottom_hit_length := (rect_size.y - h_off) * cos_angle_inv
	if offset > 0:
		bottom_hit_length += h_off * cos_angle_inv
	elif offset < 0:
		right_hit_length += w_off * cos_angle
	return min(right_hit_length, bottom_hit_length)


func add_line_sprite(line: Array, line_start: Vector2, line_speed: float, pos: float, start: bool):
	var start_time := time - pos / line_speed
	var rot := randf_sym(rot_variance * PI * 2)
	var sprite := create_sprite(line_start + forward * pos - MARGIN_SUBTRACT, rot)
	var info := [sprite, start_time, new_pos_offset(), rot, randf_sym(rot_speed_variance)]
	if start:
		line.insert(0, info)
	else:
		line.append(info)


func update_line(rect_size: Vector2, offset: float, lines: Array, index: int) -> void:
	while index >= lines.size():
		lines.append(new_line())

	var line: Array = lines[index][0]
	var line_start_offset: float = lines[index][1]
	var line_speed_offset: float = lines[index][2]

	var line_start := left * offset + forward * (calc_line_start(offset) - line_start_offset)
	var length := calc_line_length(rect_size, offset) + line_start_offset
	var line_speed := speed * line_speed_offset

	var i := 0
	var first_pos := length
	var last_pos := 0.0
	# update sprites within margins
	while i < line.size():
		var start_time: float = line[i][1]
		var pos_offset: Vector2 = line[i][2]
		var rot: float = line[i][3]
		var rot_speed: float = line[i][4]
		var pos := (time - start_time) * line_speed
		rot += (time - start_time) * rot_speed
		if i == 0:
			first_pos = pos
		if pos < length:
			last_pos = pos
			var sprite: Sprite2D = line[i][0]
			sprite.position = line_start + forward * pos + pos_offset - MARGIN_SUBTRACT
			sprite.rotation = rot
			i += 1
		else:
			break
	last_pos = max(first_pos, last_pos)
	# remove sprites past end
	if i < line.size():
		for j in range(i, line.size()):
			remove_sprite(line[j][0])
		line.resize(i)
	# add new sprites at start
	while first_pos > spacing:
		first_pos -= spacing
		add_line_sprite(line, line_start, line_speed, first_pos, true)
	# add new sprites at end (in case of screen resize)
	while last_pos < length - spacing:
		last_pos += spacing
		add_line_sprite(line, line_start, line_speed, last_pos, false)


func remove_line(lines: Array, index: int):
	var line: Array = lines[index][0]
	for i in line.size():
		remove_sprite(line[i][0])
	lines.remove_at(index)


func update_lines(rect_size: Vector2, lines: Array, start: int, end: int, inc: int):
	var idx := 0
	for offset_mult in range(start, end, inc):
		var offset := corner_offset + offset_mult * spacing
		update_line(rect_size, offset, lines, idx)
		offset_mult += inc
		idx += 1
	var to_remove := range(idx, lines.size())
	to_remove.reverse()
	for i in to_remove:
		remove_line(lines, i)


func _ready() -> void:
	angle = randf_range(0.1, PI / 2 - 0.1)
	forward = Vector2.from_angle(angle)
	left = forward.orthogonal()
	time = 0.0
	corner_offset = randf_range(0, spacing * 0.9)


func _process(delta: float) -> void:
	var dims := get_rect().size
	var margin_size := dims + Vector2.ONE * MARGIN * 2

	var min_offset := calc_min_offset(margin_size)
	var max_offset := calc_max_offset(margin_size)

	time += delta

	# offset >= 0
	update_lines(margin_size, pos_lines, 0, int((max_offset + corner_offset) / spacing), 1)

	# offset < 0
	update_lines(margin_size, neg_lines, -1, int((min_offset - corner_offset) / spacing), -1)
