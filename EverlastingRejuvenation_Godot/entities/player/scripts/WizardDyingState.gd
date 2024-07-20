class_name WizardDyingState extends State

func Enter() -> void:
	super();
	await parent.get_node("Visuals/Animations").animation_finished;
	parent.emit_signal("player_death");
