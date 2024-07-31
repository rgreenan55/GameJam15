class_name WizardDyingState extends State

func Enter() -> void:
	super();
	parent.get_node("DeathSound").playing = true;
	await parent.get_node("Visuals/Animations").animation_finished;
	parent.emit_signal("player_death");
