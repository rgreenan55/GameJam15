class_name ShadowArea extends Area2D

func _ready() -> void:
	draw_area();

func draw_area() -> void:
	var collision_shape_node : CollisionShape2D = get_node("CollisionShape2D");
	var polygon_nodes : PackedVector2Array;

	match collision_shape_node.shape.get_class():
		"RectangleShape2D": polygon_nodes = get_rectangle_nodes(collision_shape_node.shape);
		_: push_warning("ShadowArea cannot make shape from: " + collision_shape_node.shape.get_class());

	get_node("Polygon2D").polygon = polygon_nodes;
	get_node("Polygon2D").position = collision_shape_node.position;


# Determine Polygons for Shapes
func get_rectangle_nodes(collision_shape : RectangleShape2D) -> PackedVector2Array:
	var shape : Vector2 = collision_shape.size;
	var polygon_nodes : PackedVector2Array = [
		Vector2(shape.x/2, shape.y/2),
		Vector2(shape.x/2, -shape.y/2),
		Vector2(-shape.x/2, -shape.y/2),
		Vector2(-shape.x/2, shape.y/2),
	];
	return polygon_nodes;

# Player Detection Signal Handlers
func _on_body_entered(body: Node2D) -> void:
	if(body.is_in_group("Player")):
		body.entered_shadow();

func _on_body_exited(body: Node2D) -> void:
	if(body.is_in_group("Player")):
		body.exited_shadow();
