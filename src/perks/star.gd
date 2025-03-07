@tool
class_name StarPerk
extends BasePerk

static var name := "star"

static var title := "The Star"
static var description := "Regains 1 health for every 60 seconds without taking damage"

var time_without_damage := 0.0


func on_damage_taken(amount: int):
	if amount > 0:
		time_without_damage = 0


func post_init() -> void:
	Players.info[player].damage_taken.connect(on_damage_taken)


func update(delta: float) -> void:
	time_without_damage += delta
	if time_without_damage > 60:
		time_without_damage -= 60
		Players.info[player].heal(1)

