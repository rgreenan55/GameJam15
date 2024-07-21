class_name PolymorphPotion extends PotionType;

func apply_effect(node : CollisionObject2D) -> void:
	node.polymorph();
