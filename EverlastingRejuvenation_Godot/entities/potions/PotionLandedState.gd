extends State

@export var potion_area_of_effect : PackedScene;

func Enter() -> void:
	parent.get_node("Visuals").visible = false;
	var potion_area : Area2D = potion_area_of_effect.instantiate();

	potion_area.get_node("Particles").color = parent.effect.color;
	potion_area.get_node("Particles").emitting = true;
	potion_area.connect("area_entered", apply_effect);
	potion_area.connect("body_entered", apply_effect);

	get_node("Timer").start();

	parent.add_child(potion_area);

func apply_effect(node) -> void:
	if (node.is_in_group(parent.effect.group_check)):
		parent.effect.apply_effect(node);
