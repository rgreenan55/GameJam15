extends CharacterBody2D

@onready var state_machine : StateMachine = $AnimatedTorchStateMachine;

func extinguish() -> void:
	get_node("FireNoise").stop();
	state_machine.on_child_transitioned("AnimatedTorchExtinguished");
	# Should always be inside a entitypath;
	get_parent().get_parent().speed_px = 0;
