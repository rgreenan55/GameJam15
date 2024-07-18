class_name Wizard extends CharacterBody2D

signal throw_potion(start : Vector2, end : Vector2)

@onready var state_machine : StateMachine = $WizardStateMachine;

func _process(delta: float) -> void:
	if (Input.is_action_just_pressed("KillPlayer")):
		state_machine.on_child_transitioned("WizardDyingState");
