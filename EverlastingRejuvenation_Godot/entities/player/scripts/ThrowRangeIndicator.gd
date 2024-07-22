extends Line2D

func _ready() -> void:
	var radius : float = get_parent().get_node("PotionThrowArea/PotionThrowRange").shape.radius;
	var radius_change = deg_to_rad(1)
	var point_list : Array[Vector2] = [];

	for counter in 360:
		var point : Vector2 = Vector2(cos(radius_change*counter), sin(radius_change*counter))*radius
		point_list.append(point);
		counter += 1;
	points = point_list;
