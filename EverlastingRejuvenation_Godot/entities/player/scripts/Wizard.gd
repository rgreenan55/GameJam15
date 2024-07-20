class_name Wizard extends CharacterBody2D

signal player_death();
signal throw_potion(start : Vector2, end : Vector2);

@onready var state_machine : StateMachine = $WizardStateMachine;

func hit_by_light() -> void:
	state_machine.on_child_transitioned("WizardDyingState");
