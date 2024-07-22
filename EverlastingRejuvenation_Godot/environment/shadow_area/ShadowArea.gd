class_name ShadowArea extends Area2D

func _ready() -> void:
	draw_area();

func draw_area() -> void:
	var collision_shape : CollisionShape2D = get_node("CollisionShape2D");
	var shape : Vector2 = collision_shape.shape.size;

	var polygon_nodes : PackedVector2Array = [
		Vector2(shape.x/2, shape.y/2),
		Vector2(shape.x/2, -shape.y/2),
		Vector2(-shape.x/2, -shape.y/2),
		Vector2(-shape.x/2, shape.y/2),
	];
	get_node("Polygon2D").polygon = polygon_nodes;
	get_node("Polygon2D").position = collision_shape.position;



func _on_body_entered(body: Node2D) -> void:
	if(body.is_in_group("Player")):
		body.entered_shadow();

func _on_body_exited(body: Node2D) -> void:
	if(body.is_in_group("Player")):
		body.exited_shadow();
