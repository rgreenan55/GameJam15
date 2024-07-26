class_name IcePotion extends PotionType;

func apply_effect(node : CollisionObject2D) -> void:
	node.freeze();
