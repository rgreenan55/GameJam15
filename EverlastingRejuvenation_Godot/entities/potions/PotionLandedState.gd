extends State

@export var potion_area_of_effect : PackedScene;

func Enter() -> void:
	parent.get_node("Visuals").visible = false;
	var potion_area : Area2D = potion_area_of_effect.instantiate();
	potion_area.get_node("Particles").color = parent.effect;
	potion_area.get_node("Particles").emitting = true;

	parent.add_child(potion_area);
