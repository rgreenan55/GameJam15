extends State

func Enter() -> void:
	if (parent.get_node("Visuals/Animations").current_animation == "alert"):
		parent.get_node("Visuals/Animations").play_backwards("transition");
		await parent.get_node("Visuals/Animations").animation_finished;
	parent.get_node("Visuals/Animations").play("idle");
	parent.get_node("LightSource").force_extinguish();
