class_name WizardIdleState extends State

func Process_Input(event : InputEvent) -> void:
	if (event is InputEventKey):
		transitioned.emit("WizardWalkingState");

func Enter() -> void:
	super();
	get_node("LongIdleDelay").start();

func Exit() -> void:
	get_node("LongIdleDelay").stop();

func _on_long_idle_delay_timeout() -> void:
	parent.get_node("Visuals/Animations").play("long_idle_start");
