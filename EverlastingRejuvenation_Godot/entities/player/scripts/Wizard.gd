class_name Wizard extends CharacterBody2D

signal player_death();
signal throw_potion(start : Vector2, end : Vector2);

@onready var state_machine : StateMachine = $WizardStateMachine;

func _on_light_detector_area_entered(area: Area2D) -> void:
	if (area.is_in_group("LightSource")):
		state_machine.on_child_transitioned("WizardDyingState");
