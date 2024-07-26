class_name WaterPotion extends PotionType;

func apply_effect(node : CollisionObject2D) -> void:
	# Get parent as this is typically of light source where area is a child of the light source.
	node.get_parent().extinguish();
