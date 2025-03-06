class_name Util
extends Object


static func update_object_count(objects: Array, count: int, make_new: Callable) -> void:
	if objects.size() > count:
		for i in objects.size() - count:
			objects[count + i].queue_free()
		objects.resize(count)
	while objects.size() < count:
		objects.append(make_new.call())


static func checked_connect(sig: Signal, method: Callable) -> void:
	if not sig.is_connected(method):
		sig.connect(method)


static func checked_disconnect(sig: Signal, method: Callable) -> void:
	if sig.is_connected(method):
		sig.disconnect(method)


static func rand_vec() -> Vector2:
	return Vector2.from_angle(randf_range(0, PI * 2))


static func randb() -> bool:
	return randi() % 2 == 0
