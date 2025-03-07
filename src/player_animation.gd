extends Node2D

enum State {
	CAST,
	CAST_REV,
	WALK,
	IDLE,
	DEAD,
	NONE,
}

var state := State.NONE

@onready var player: Player = $".."
@onready var base: AnimatedSprite2D = $"../Base"
@onready var robe: AnimatedSprite2D = $"../Robe"
@onready var belt: AnimatedSprite2D = $"../Belt"


func switch_sprite_animation(sprite: AnimatedSprite2D, anim: String, reset: bool, reverse: bool):
	var frame := sprite.frame
	var progress := sprite.frame_progress
	sprite.play(anim, -1 if reverse else 1, reverse)
	if not reset:
		sprite.set_frame_and_progress(frame, progress)


func switch_animation(anim: String, reset := true, reverse := false) -> void:
	switch_sprite_animation(base, anim, reset, reverse)
	switch_sprite_animation(robe, anim, reset, reverse)
	switch_sprite_animation(belt, anim, reset, reverse)


func _ready() -> void:
	switch_animation("idle")


func _process(_delta: float) -> void:
	if player.is_dead:
		if state != State.DEAD:
			switch_animation("death")
			state = State.DEAD
	elif player.is_casting:
		if state != State.CAST:
			switch_animation("cast")
			state = State.CAST
	elif state == State.CAST:
		if state != State.CAST_REV:
			switch_animation("cast", false, true)
			state = State.CAST_REV
	elif state != State.CAST_REV:
		if player.is_moving:
			switch_animation("walk")
			state = State.WALK
		else:
			switch_animation("idle")
			state = State.IDLE
