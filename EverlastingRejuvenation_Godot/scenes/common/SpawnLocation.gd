class_name SpawnLocation extends Area2D

func get_spawn_position() -> Vector2:
	var size : Vector2 = get_node("Shape").shape.size;
	var spawn_x = randf_range(position.x - size.x/2, position.x + size.x/2);
	var spawn_y = randf_range(position.y - size.y/2, position.y + size.y/2);
	return position;
