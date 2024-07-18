class_name WizardWalkingState extends State

const SPEED : float = 100;

func Exit() -> void:
	parent.get_node("Sprite").get_node("WalkingParticles").emitting = false;

func Update(_delta: float) -> void:
	# Handle Sprite Direction Based on Movement
	parent.get_node("Sprite").get_node("WalkingParticles").emitting = true;
	if (parent.velocity.x != 0):
		if (parent.velocity.x < 0):
			parent.get_node("Sprite").flip_h = true;
		else:
			parent.get_node("Sprite").flip_h = false;

func Physics_Update(_delta: float) -> void:
	var direction = Input.get_vector("MoveLeft", "MoveRight", "MoveUp", "MoveDown");
	parent.velocity = direction * SPEED;
	parent.move_and_slide();

	if (parent.velocity == Vector2.ZERO):
		transitioned.emit(&"WizardIdleState")
