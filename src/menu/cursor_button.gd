extends ButtonSound

var focused_style: StyleBox
var focused := false


func _ready() -> void:
	super()
	mouse_filter = MOUSE_FILTER_IGNORE
	toggle_mode = true
	focused_style = get_theme_stylebox("focus", theme_type_variation)


func _draw() -> void:
	if not disabled and focused:
		focused_style.draw(get_canvas_item(), Rect2(Vector2.ZERO, size))


func _process(_delta: float) -> void:
	if disabled:
		return
	var cursor_inside := false
	var cursor_pressing := false
	for device_id in Players.info:
		var info: PlayerInfo = Players.info[device_id]
		if not info.cursor_in(get_global_rect()):
			continue
		cursor_inside = true
		cursor_pressing = info.is_pressing()
		if info.has_pressed():
			pressed.emit()
	if cursor_inside != focused:
		queue_redraw()
	focused = cursor_inside
	button_pressed = cursor_pressing
