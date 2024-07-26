class_name ExplosivePotion extends PotionType;

func apply_effect(node : CollisionObject2D) -> void:
	node.explode();
