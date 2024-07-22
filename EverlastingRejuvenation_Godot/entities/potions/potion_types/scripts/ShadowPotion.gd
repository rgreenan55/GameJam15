class_name ShadowPotion extends PotionType;

var shadow_area_scene : PackedScene = load("res://environment/shadow_area/ShadowArea.tscn");

func perform_on_landing(parent : Node2D) -> void:
	var shadow_area = shadow_area_scene.instantiate();
	var collision_shape = CollisionShape2D.new();
	collision_shape.name = "CollisionShape2D";
	collision_shape.shape = CircleShape2D.new();
	collision_shape.shape.radius = 32;
	shadow_area.add_child(collision_shape);
	shadow_area.time_to_expire = 4.0;
	shadow_area.z_index = 100;
	shadow_area.position = parent.position;
	parent.add_sibling(shadow_area);
