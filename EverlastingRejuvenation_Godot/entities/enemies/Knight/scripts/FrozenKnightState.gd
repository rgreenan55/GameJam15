class_name FrozenKnightState extends State

func Enter() -> void:
	parent.velocity = Vector2.ZERO;
	parent.get_node("Visuals/Animations").pause();
	parent.get_node("Visuals/FreezeCoverSprite").play("active");

func Exit() -> void:
	parent.get_node("Visuals/FreezeCoverSprite").play("default");
