@tool
extends TextureRect

@export var start_offset := Vector2.ZERO
@export var region_size := Vector2.ONE
@export var vertical := false
@export var frame_count := 1
@export var frame_length := 1.0
@export var disable_animation := false

var frame_num := 0
var frame_progress := 0.0


func update_atlas(frame: int):
    if not texture is AtlasTexture:
        return
    var offset := start_offset
    if vertical:
        offset.y += region_size.y * frame
    else:
        offset.x += region_size.x * frame
    var atlas: AtlasTexture = texture
    atlas.region.size = region_size
    atlas.region.position = offset


func _ready() -> void:
    if not texture is AtlasTexture:
        print("texture must be AtlasTexture!")
    else:
        texture = texture.duplicate()


func _process(delta: float) -> void:
    if disable_animation or frame_count == 1:
        return
    var prev_frame := frame_num
    frame_progress += delta
    while frame_progress > frame_length:
        frame_progress -= frame_length
        frame_num += 1
    frame_num %= frame_count
    if frame_num != prev_frame:
        update_atlas(frame_num)


func _notification(what: int) -> void:
    if what == NOTIFICATION_EDITOR_PRE_SAVE:
        update_atlas(0)
    elif what == NOTIFICATION_EDITOR_POST_SAVE:
        update_atlas(frame_num)

