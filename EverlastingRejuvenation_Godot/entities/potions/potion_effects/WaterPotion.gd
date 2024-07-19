class_name WaterPotion extends PotionEffect;

func apply_effect(node : CollisionObject2D) -> void:
	node.get_parent().extinguish();
