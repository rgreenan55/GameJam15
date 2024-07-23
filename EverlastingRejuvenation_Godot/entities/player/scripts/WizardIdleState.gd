class_name WizardIdleState extends State

@onready var long_idle_timer : Timer = get_node("LongIdleDelay");

func Process_Input(event : InputEvent) -> void:
	if (event is InputEventKey):
		transitioned.emit("WizardWalkingState");

func Enter() -> void:
	super();
	long_idle_timer.start();

func Exit() -> void:
	long_idle_timer.stop();

func _on_long_idle_delay_timeout() -> void:
	parent.get_node("Visuals/Animations").play("long_idle_start");
