extends CharacterBody2D


func cast() -> void:
	$robe.play("cast")
	$belt.play("cast")
	$base.play("cast")


func idle() -> void:
	$robe.play("idle")
	$belt.play("idle")
	$base.play("idle")


func walk() -> void:
	$robe.play("walk")
	$belt.play("walk")
	$base.play("walk")
