class_name WizardIdleState extends State

func Enter() -> void:
	super();
	parent.get_node("LongIdleDelay").start();

func Exit() -> void:
	parent.get_node("LongIdleDelay").stop();

func Process_Input(event : InputEvent) -> void:
	if (event is InputEventKey):
		transitioned.emit("WizardWalkingState");

func _on_long_idle_delay_timeout() -> void:
	parent.get_node("Visuals/Animations").play("long_idle_start");
