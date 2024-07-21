class_name WaterPotion extends PotionType;

func apply_effect(node : CollisionObject2D) -> void:
	node.get_parent().extinguish();
