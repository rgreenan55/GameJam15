extends State

func Enter() -> void:
	parent.get_node("Visuals/Animations").play("transition");
	await parent.get_node("Visuals/Animations").animation_finished;
	parent.get_node("Visuals/Animations").play("alert");
	parent.get_node("LightSource").relight();
