class_name WizardIdleState extends State

func Process_Input(_input : InputEvent) -> void:
	transitioned.emit("WizardWalkingState");
