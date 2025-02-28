class_name VariableObjects
extends Object


static func update_object_count(objects: Array[Node], count: int, make_new: Callable):
	if objects.size() > count:
		for i in objects.size() - count:
			objects[count + i].queue_free()
		objects.resize(count)
	while objects.size() < count:
		objects.append(make_new.call())
