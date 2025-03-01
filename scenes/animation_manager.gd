extends CharacterBody2D

func cast():
    $robe.play("cast")
    $belt.play("cast")
    $base.play("cast")
func idle():
    $robe.play("idle")
    $belt.play("idle")
    $base.play("idle")
func walk():
    $robe.play("walk")
    $belt.play("walk")
    $base.play("walk")