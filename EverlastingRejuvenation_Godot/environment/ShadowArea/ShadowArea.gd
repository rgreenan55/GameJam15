class_name ShadowArea extends Area2D

@export var time_to_expire : float = 0;
@export var draw_sprite : PackedScene;

func _ready() -> void:
	if (time_to_expire > 0):
		get_node("Timer").start(time_to_expire);

func draw_area() -> void:
	if (!has_node("CollisionShape2D")): return;
	var collision_shape_node : CollisionShape2D = get_node("CollisionShape2D");
	var polygon_nodes : PackedVector2Array;

	# Handle Point Collection for Each CollisionShape
	match collision_shape_node.shape.get_class():
		"RectangleShape2D":
			polygon_nodes = get_rectangle_nodes(collision_shape_node.shape);
		"CircleShape2D":
			polygon_nodes = get_circle_nodes(collision_shape_node.shape)
		"ConvexPolygonShape2D":
			# Doesnt work
			polygon_nodes = collision_shape_node.shape.points;
		"ConcavePolygonShape2D":
			# Doesnt work
			polygon_nodes = collision_shape_node.shape.segments;
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

func get_circle_nodes(collision_shape : CircleShape2D) -> PackedVector2Array:
	var radius = collision_shape.radius;
	var radius_change = deg_to_rad(1)
	var point_list : PackedVector2Array = [];
	for counter in 360:
		var point : Vector2 = Vector2(cos(radius_change*counter), sin(radius_change*counter))*radius
		point_list.append(point);
		counter += 1;
	return point_list;

# Sprite Drawing
func draw_sprites() -> void:
	pass;

# Player Detection Signal Handlers
func _on_body_entered(body: Node2D) -> void:
	if(body.is_in_group("Player")):
		body.entered_shadow();

func _on_body_exited(body: Node2D) -> void:
	if(body.is_in_group("Player")):
		body.exited_shadow();

func _on_child_entered_tree(node: Node) -> void:
	if (node.get_class() == "CollisionShape2D"):
		draw_area()
		draw_sprites();
